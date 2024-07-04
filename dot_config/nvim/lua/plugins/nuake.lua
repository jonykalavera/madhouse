return {
    "Lenovsky/nuake",
    config = function ()
        -- nnoremap <F4> :Nuake<CR>
        -- inoremap <F4> <C-\><C-n>:Nuake<CR>
        -- tnoremap <F4> <C-\><C-n>:Nuake<CR>
        vim.keymap.set('n', '<F4>', '<CMD>:Nuake<CR>', {noremap = true})
    end
}
