
# Gunzip file
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

%% back to main placeholder
[back to index](index.md)
