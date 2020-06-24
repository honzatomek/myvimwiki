
# gunzip file
```python3
import gzip
import shutil

def gunzip(source_filepath, dest_filepath, block_size=65536):
    '''
    Function to gunzip a file.
    '''
    with gzip.open(source_filepath, 'rb') as s_file, open(dest_filepath, 'wb') as d_file:
        shutil.copyfileobj(s_file, d_file, block_size)
```

# argparse custom action
```python3
class InvalidInputError(Exception):
    pass


class CheckFile(argparse.Action):
    def __init__(self, option_strings, dest, **kwargs):
        super(CheckFile, self).__init__(option_strings, dest, **kwargs)

    def __call__(self, parser, namespace, values, option_string=None):
        # print('%r %r %r' % (namespace, values, option_string))
        print('{0} Checking {1} file(s):'.format(TAG['info'], self.metavar))
        if len(values) < 2:
            print('    {0} The number of files must be > 1.'.format(TAG['error']))
            raise InvalidInputError
        else:
            print('    {0} Number of input files: {1}'.format(TAG['ok'], len(values)))
        for value in values:
            if not os.path.isfile(value):
                print('    {0} {1} exists: False'.format(TAG['error'], coltext(value, 'red')))
                raise InvalidInputError('{0} must be an existing file.'.format(value))
            else:
                print('    {0} {1} exists: True'.format(TAG['ok'], coltext(value)))
            if not value.upper().endswith('.' + EXT.upper()):
                print('    {0} {1} is *.{2} file: False'.format(TAG['error'], coltext(value, 'red'), EXT))
                raise InvalidInputError('{0} must be a *.{1} file.'.format(value, EXT))
            else:
                print('    {0} {1} is *.{2} file: True'.format(TAG['ok'], coltext(value), EXT))

        setattr(namespace, self.dest, values)


if __name__ == '__main__':
    '''
    Main entry point of the script.
    '''
    parser = argparse.ArgumentParser(description=__doc__, epilog='[CWD: {0}]\n'.format(os.getcwd()),
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('-v', '--verbose', action='store_true', default=False,
                        help='Verbose information.')
    parser.add_argument('-s', '--outputset', type=str, nargs='?', default='0001',
                        help='Output set identifier. (default = 0001)')
    parser.add_argument('-n', '--name', type=str, nargs='?', default='NaN',
                        help='Name of output set. (default = NaN)')
    parser.add_argument('txt', metavar='EVASST', nargs='+', default=None, type=str, action=CheckFile,
                        help='EVASST *.{0} files to be merged.'.format(EXT))

    args = parser.parse_args()

    sst_merge(args.txt, args.outputset, args.name, args.verbose)
```

%% back to main placeholder
[back to index](index.md)
