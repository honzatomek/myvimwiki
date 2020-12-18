# Contents

    - [gunzip file](#gunzip file)
    - [argparse](#argparse)
        - [custom action](#argparse#custom action)
        - [mutually exclusive arguments](#argparse#mutually exclusive arguments)
    - [ENCRYPT password using RSA key](#ENCRYPT password using RSA key)
        - [generate RSA key pairs](#ENCRYPT password using RSA key#generate RSA key pairs)
        - [encrypt password](#ENCRYPT password using RSA key#encrypt password)
        - [decrypt password](#ENCRYPT password using RSA key#decrypt password)
        - [test encryption - decryption](#ENCRYPT password using RSA key#test encryption - decryption)
    - [class](#class)
        - [instance counter](#class#instance counter)
            - [metaclass](#class#instance counter#metaclass)
    - [numpy](#numpy)
        - [eigenvalues](#numpy#eigenvalues)

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

# argparse
## custom action
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

## mutually exclusive arguments
From: https://stackoverflow.com/questions/17909294/python-argparse-mutual-exclusive-group

```python3
import argparse

if __name__ == '__main__':
    # create the top-level parser
    parser = argparse.ArgumentParser(prog='PROG')
    parser.add_argument('--foo', action='store_true', help='help for foo arg.')
    subparsers = parser.add_subparsers(help='help for subcommand')

    # create the parser for the "command_1" command
    parser_a = subparsers.add_parser('command_1', help='command_1 help')
    parser_a.add_argument('a', type=str, help='help for bar, positional')

    # create the parser for the "command_2" command
    parser_b = subparsers.add_parser('command_2', help='help for command_2')
    parser_b.add_argument('-b', type=str, help='help for b')
    parser_b.add_argument('-c', type=str, action='store', default='', help='test')
```

# ENCRYPT password using RSA key
https://stackoverflow.com/questions/2466401/how-to-generate-ssh-key-pairs-with-python

## generate RSA key pairs
```python
#!/usr/bin/env python3
import os
from subprocess import Popen, PIPE


def generate_rsa_key_pair(keyname='generated_rsa', password=None):
    '''
    Generates RSA public/private key pair.
    idea from: https://stackoverflow.com/questions/2466401/how-to-generate-ssh-key-pairs-with-python
    In:
        keyname:  generated RSA key pair name
    Optional:
        password: optional password for the RSA key
    Out:
        RSA key pair
    '''
    print('[+] generating RSA key pair.')
    if keyname is None:
        path = os.path.join(os.getcwd(), 'generated_rsa')
    else:
        path = keyname

    if os.path.isfile(path):
        print('[+] removing existing file: {0}'.format(path))
        os.remove(path)

    if os.path.isfile(path + '.pub'):
        print('[+] removing existing file: {0}'.format(path + '.pub'))
        os.remove(path + '.pub')

    cmd = ['ssh-keygen', '-m', 'PEM', '-t', 'rsa', '-f', path]
    if password:
        cmd.append('-P')
        cmd.append(password)

    p = Popen(cmd, stdout=PIPE)
    p.wait()
    res, err = p.communicate()

    if err:
        raise Exception(err)

    if res:
        cert_content = res.decode('utf-8')
        print('[+] Certificate: {0}'.format(cert_content))

    return path, path + '.pub'
```

## encrypt password
```python
#!/usr/bin/env python3
import os
from Cryptodome.PublicKey import RSA
from Cryptodome.Random import get_random_bytes
from Cryptodome.Cipher import AES, PKCS1_OAEP


def encrypt(string_to_encrypt, public_key, encrypted_file='password.bin'):
    '''
    ENCRYPTS a string using RSA - AES key combination. First an AES session key
    is generated, then it is used to encrypt the string_to_encrypt. Aftwerwards
    the AES session key is encrypted using the RSA public key and the encrypted
    AES key is stored together with the encrypted string_to_encrypt in a file.
    This has the advantage of encrypting strings too short for a RSA encryption
    (e.g. passwords).

    WARNING: Does not work if RSA key has password.

    In:
        string_to_encrypt: string to be encrypted
        public_key:        file with RSA public key
    Optional:
        encrypted_file:    filename where to store the ecrypted string
                           (DEFAULT = password.bin)'
    Out:
        file with the encrypted string
    '''

    assert(type(string_to_encrypt) == str), 'string_to_encrypt ({0}) must be a string.'.format(string_to_encrypt)
    assert(string_to_encrypt != ''), 'string_to_encrypt cannot be a nullstring'
    assert(os.path.isfile(public_key)), 'public_key file ({0}) does not exist'.format(public_key)

    recipient_key = RSA.importKey(open(public_key, 'r').read())
    session_key = get_random_bytes(16)

    # Encrypt the session key with the public RSA key
    cipher_rsa = PKCS1_OAEP.new(recipient_key)
    enc_session_key = cipher_rsa.encrypt(session_key)

    # Encrypt the data with the AES session key
    # EAX mode is used to allow detection of unauthoriyed modifications
    cipher_aes = AES.new(session_key, AES.MODE_EAX)
    ciphertext, tag = cipher_aes.encrypt_and_digest(string_to_encrypt.encode('utf-8'))

    with open(encrypted_file, 'wb') as file_out:
        [file_out.write(x) for x in (enc_session_key,
                                     cipher_aes.nonce,
                                     tag,
                                     ciphertext)]

    return encrypted_file
```

## decrypt password
```python
#!/usr/bin/env python3
import os
from Cryptodome.PublicKey import RSA
from Cryptodome.Random import get_random_bytes
from Cryptodome.Cipher import AES, PKCS1_OAEP


def decrypt(string_to_decrypt, private_key):
    '''
    DECRYPTS a string ENCRYPTED using RSA - AES key combination. RSA encrypted
    key is extracted from the string_to_decrypt, decrypted using RSA private
    key and the ewsulting AES session key is used to decrypt the encrypted
    string stored at the end of the string_to_decrypt file.

    WARNING: Does not work if RSA key has password.

    In:
        string_to_decrypt: file with (RSA encrypted AES session key, AES
                           session key NONCE, TAG, encrypted text)
        private_key:       RSA private key filename
    Out:
        decrypted string if everything works, AssertionError if not
    '''

    assert(os.path.isfile(string_to_decrypt)), 'string_to_decrypt {0} is not a file.'.format(string_to_decrypt)
    assert(os.path.isfile(private_key)), 'private_key file ({0}) does not exist.'.format(private_key)

    key = RSA.importKey(open(private_key, 'r').read())

    with open(string_to_decrypt, 'rb') as file_in:
        enc_session_key, nonce, tag, ciphertext = [file_in.read(x) for x in (key.size_in_bytes(), 16, 16, -1)]

    # Decrypt the session key with the private RSA key
    cipher_rsa = PKCS1_OAEP.new(key)
    session_key = cipher_rsa.decrypt(enc_session_key)

    # Decrypt the data with the AES session key
    cipher_aes = AES.new(session_key, AES.MODE_EAX, nonce)
    decrypted_string = cipher_aes.decrypt_and_verify(ciphertext, tag)

    return decrypted_string.decode('utf-8')
```

## test encryption - decryption
```python
#!/usr/bin/env python3
import os
from mycrypto import encrypt, decrypt # it is presumed that the functions above are stored in mycrypto.py

def test_encryption(private_key=None, public_key=None, test_string='This is a test string'):
    '''
    Tests if encrypt() and decrypt() functions work both ways. First the
    test_string is ENCRYPTED, then the encrypted string is DECRYPTED and the
    result is checked.

    In:
        private_key: RSA private key file
        public_key:  RSA public key file
        test_string: String to test the ecryption on
                     (DEFAULT = 'This is a test string')
    Out:
        True if the ENCRYPTION - DECRYPTION works, AssertionError if not.
    '''

    assert(private_key is None), '[-] No private key supplied. Encryption cannot be tested.'
    assert(public_key is None), '[-] No public key supplied. Encryption cannot be tested.'

    print('[+] Private key: {0}'.format(private_key))
    print('[+] Public key: {0}'.format(public_key))

    test_string = 'this is a test string'
    print('test string: {0}'.format(test_string))
    encrypted = encrypt(test_string, public_key, )

    decrypted = decrypt(encrypted, private_key)
    print('decrypted string: {0}'.format(decrypted))

    assert(test_string == decrypted), 'Encryption -> Decryption did not work: {0} != {1}'.format(test_string, decrypted)
    os.remove(encrypted)

    return True
```

# class
## instance counter
### metaclass
From: https://rednafi.github.io/digressions/python/2020/06/26/python-metaclasses.html#special-methods-used-by-metaclasses
From: https://www.python-course.eu/python3_metaclasses.php
From: https://stackoverflow.com/questions/8628123/counting-instances-of-a-class

```python3
import weakref
import logging

# logging.basicConfig(level=logging.INFO, format='%(asctime)-8s%(levelname)-8s%(message)s', datefmt='%H%M%S')
logging.basicConfig(level=logging.INFO, format='%(asctime)6s *%(levelname).1s* %(message)s', datefmt='%H%M%S')


class MetaCount(type):
    def __new__(cls, name, bases, attrs):
        new_cls = super(MetaCount, cls).__new__(cls, name, bases, attrs)
        new_cls._instances = set()
        return new_cls


class Parent(metaclass=MetaCount):
    def __init__(self):
        type(self)._instances.add(weakref.ref(self))
        logging.info(f'classname: {type(self).__name__}')
        logging.info(f'baseclasses: {type(self).__bases__}')
        logging.info(f'attributes: {type(self).__dict__}')
        logging.info(f'instances: {len(type(self)._instances)}')

    @classmethod
    def count(cls):
        return len(cls._instances)

    @classmethod
    def get_instances(cls):
        dead = set()
        for ref in cls._instances:
            obj = ref()
            if obj is not None:
                yield obj
            else:
                dead.add(ref)
        cls._instances -= dead


class Child(Parent):
    def __init__(self):
        super().__init__()


class SubChild(Child):
    def __init__(self):
        super().__init__()


p = Parent()
c1 = Child()
c2 = Child()
s = SubChild()

print(p.count())
print(c1.count())
print(c2.count())
print(s.count())
```

# numpy
## eigenvalues
%% eigenvalues, choleski, LL, eigenvectors, numpy, scipy
```python3
import numpy as np
from scipy import linalg

if __name__ == '__main__':
    """
    transform generalised eigenvalue problem [K]{v} = w^2[M]{v}
    to standard eigenvalue problem [A]{x} = lambda {x}
    using Cholseky decomposition of [M] = [L] [L]T
    then                      [K]{v} = w^2[M]{v}
    becomes                   [K]{v} = w^2 [L] [L]T {v}
    and finally  [L]-1 [K] [L]-T {v} = w^2 {v}
    """
    M = np.array([[2., 1., 0., 0.],
                  [1., 4., 1., 0.],
                  [0., 1., 4., 1.],
                  [0., 0., 1., 2.]], dtype=float)
    K = np.array([[1., -1., 0., 0.],
                  [-1., 2., -1., 0.],
                  [0., -1., 2., -1.],
                  [0., 0., -1., 1.]], dtype=float)

    # Cholesky decomposition
    L = linalg.cholesky(M, lower=True)

    # Inverse of lower triangular matrix
    L1 = linalg.inv(L)

    # scipy exact solution
    eigs1, evec1 = linalg.eigh(K, M)

    # solution using decomposition
    eigs2, evec2 = linalg.eigh(L1 @ K @ L1.T)

    # check results
    diff = eigs1 - eigs2
    check = np.abs(diff) < 0.00001
    assert check.all()

    pass
```


%% back to main placeholder
[back to index](index.md)
