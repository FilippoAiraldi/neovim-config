return {
	{
		"numToStr/Comment.nvim",
		config = function()
			local C = require("Comment")
			local U = require("Comment.utils")
			C.setup({
				ignore = "^$",  -- ignore empty lines
				toggler = { line = "<leader>/" },
				opleader = { line = "<leader>/" },
				post_hook = function(ctx)  
					-- https://github.com/numToStr/Comment.nvim/discussions/299
					if ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
						vim.cmd("norm! gv")
					end
				end,
			})
			
		end
	},
}
