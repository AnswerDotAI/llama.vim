" Test suite for llama.vim edit history tracking

function! TestEditHistory()
    " Clear history
    let s:edit_history = []
    let s:last_edit_time = 0
    let s:last_edit_pos = [0, 0]
    
    " Create test buffer
    new
    call setline(1, ['line1', 'line2', 'line3'])
    
    " Simulate edit
    normal! G
    call setline(3, 'edited line3')
    call s:track_edit()
    
    " Verify edit was tracked
    if len(s:edit_history) != 1
        throw "Edit not tracked"
    endif
    
    let l:edit = s:edit_history[0]
    if l:edit.lines != ['line2', 'edited line3']
        throw "Wrong edit context"
    endif
    
    " Clean up
    bdelete!
endfunction
