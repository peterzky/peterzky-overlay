project('updater', 'c',
        version : '0.1',
        default_options : ['warning_level=3',
                           'c_std=c11'])

libuv = dependency('libuv')
json = dependency('json-c')

exe = executable('main', 'src/main.c', dependencies: [json, libuv], install : true)
