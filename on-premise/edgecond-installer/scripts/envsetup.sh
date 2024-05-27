#! /usr/bin/env python3

import argparse
import json
import os
import re
import sys

preset = {}


def get_args():
    parser = argparse.ArgumentParser(
        description='Creating a setup from a template file',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog='''
* pre-defined: value from .env

* template rules:
  1. key = not value type (comments)
    template 
  2. key =
    pre-defined, user input value
  3. key = ? command
    pre-defined, command value, user input value
  4. key = ! command
    pre-defined, command value
  5. key = * [default]
    pre-defined, default, user input value, allow empty value
  6. key = value
    value
  7. key = $ [environment variable]
    environment variable value of the specified variable or key
''')

    parser.add_argument('-c', '--clear', action='store_true', default=False,
                        help='do not load existing file')
    parser.add_argument('-t', '--template', type=str,
                        default='./config/.env.template',
                        help='template file path. default: ./scripts/env')
    parser.add_argument('-o', '--output-file', type=str, default='./config/.env.dev',
                        help='output directory path. default: ./config/.env.dev')
    return parser.parse_args()


def load_env(fname):
    try:
        with open(fname, 'rt') as f:
            tmp = {}
            for line in f.readlines():
                line = re.sub(r'#.*', '', line).strip()
                if not line:
                    continue
                key, val = map(str.strip, line.split('='))
                tmp[key] = val.strip("'")
            return tmp
    except FileNotFoundError:
        pass
    return {}


def prompt(key, val='', required=True):
    try:
        while True:
            tip = '' if val or required else ''
            res = input(f'{key} [{val}]{tip} ').strip()
            if res:
                return res
            if val or not required:
                return val
    except (EOFError, KeyboardInterrupt):
        print()
        sys.exit()


def process(line):
    def shell(cmd):
        return os.popen(cmd).read().strip()

    tmp = re.sub(r'#.*', '', line).strip()
    if tmp.find('=') == -1:
        line = line.strip()
        if not line.startswith('#'): print(line)
        return line

    key, val = map(str.strip, tmp.split('='))

    if key in ('BACKEND_CORS_ORIGINS',):
        return None
    if not val:
        val = preset.get(key, '')
        val = prompt(key, val)
    elif val[0] == '?':
        val = preset.get(key) or shell(val[1:])
        val = prompt(key, val)
    elif val[0] == '!':
        val = preset.get(key) or shell(val[1:])
    elif val[0] == '*':
        val = preset.get(key) or val[1:].strip().strip("'")
        val = prompt(key, val, False)
    elif val[0] == '$':
        val = os.environ.get(val[1:].strip() or key) or ''
        val = prompt(key, val, False)
    else:
        val = val.strip("'")

    if len(val.split()) > 1:
        val = f"'{val}'"

    return f'{key}={val}'


def add_cors(output):
    server = next((o.split('=')[1] for o in output if o.split('=')[0] == 'SERVER_IP'), None)
    port = next((o.split('=')[1] for o in output if o.split('=')[0] == 'FRONTEND_PORT'), None)
    if not server or not port:
        raise Exception('No SERVER_IP or FRONTEND_PORT')

    local_origins = [f'http://localhost:{port}', f'http://{server}:{port}']

    key = 'BACKEND_CORS_ORIGINS'
    prev_origins = json.loads(preset.get(key, '[]'))
    origins = list(set(prev_origins + local_origins))
    val = prompt(key, json.dumps(origins)[1:-1])

    output.append(f"{key}='[{val}]'")


def main():
    global preset

    args = get_args()
    env_path = args.output_file

    if not args.clear:
        preset = load_env(env_path)

    output = []
    with open(args.template, 'rt') as f:
        output = [process(line) for line in f.readlines()]

    # extra handling
    output = [out for out in output if out is not None]
    add_cors(output)

    with open(env_path, 'wt') as f:
        f.write('\n'.join(output))
        f.write('\n')


if __name__ == '__main__':
    main()
