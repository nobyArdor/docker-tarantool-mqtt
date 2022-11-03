#!/usr/bin/env tarantool

box.cfg{listen = 3301,  log_level = 5, read_only = false, force_recovery = true }

box.once("bootstrap", function()
 box.schema.space.create('user_tick', {
    if_not_exists = true,
    format = {
        {'id', type = 'unsigned'},
        {'day', type = 'unsigned'},
        {'tick_time', type = 'unsigned'},
        {'speed', type = 'double'}
    }
})

box.schema.sequence.create('row_id',{})
box.space.user_tick:create_index('primary', { 
    sequence = 'row_id'
})

box.space.user_tick:create_index('speed', { 
    if_not_exists = true,
    unique = false,
    type = 'tree',
    parts = {
        'speed',
    }
})
end)

s = box.space.user_tick

local function print_state()
    print('full len', s:len())
    print('--->')
    for _, v in s:pairs(nil, {iterator = box.index.ALL}) do
        print (v)
    end
    print('<---')

    print('++++>')
    for _, v in s.index.speed:pairs(nil, {iterator = box.index.ALL}) do
        print (v)
    end
    print('<++++')
end

 s:insert{nil, 1, 6814, 15038256.8705186}

 print_state()
s:insert{nil, 1, 6953, 14924076.1263006}
print_state()
s:truncate()
--print_state()
box.snapshot()
os.exit(true, true)
