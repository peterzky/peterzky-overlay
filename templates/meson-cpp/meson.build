project('nix_example_cpp', 'cpp',
  version : '0.1',
  default_options : ['warning_level=3',
                     'cpp_std=c++20'])


sqlite = dependency('sqlite3')

exe = executable('main', 'src/main.cpp', dependencies: sqlite, install : true)
