return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.startify")

		local headers = {
			[0] = {
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                     ]],
				[[       ████ ██████           █████      ██                     ]],
				[[      ███████████             █████                             ]],
				[[      █████████ ███████████████████ ███   ███████████   ]],
				[[     █████████  ███    █████████████ █████ ██████████████   ]],
				[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
				[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
				[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                       ]],
			},
			[1] = {
				[[            ___           _,.---,---.,_                                 ]],
				[[            |         ,;~'             '~;,                             ]],
				[[            |       ,;                     ;,                           ]],
				[[   Frontal  |      ;                         ; ,--- Supraorbital Foramen]],
				[[    Bone    |     ,'                         /'                         ]],
				[[            |    ,;                        /' ;,                        ]],
				[[            |    ; ;      .           . <-'  ; |                        ]],
				[[            |__  | ;   ______       ______   ;<----- Coronal Suture     ]],
				[[           ___   |  '/~"     ~" . "~     "~\'  |                        ]],
				[[           |     |  ~  ,-~~~^~, | ,~^~~~-,  ~  |                        ]],
				[[ Maxilla,  |      |   |        }:{        | <------ Orbit               ]],
				[[Nasal and  |      |   l       / | \       !   |                         ]],
				[[Zygomatic  |      .~  (__,.--" .^. "--.,__)  ~.                         ]],
				[[  Bones    |      |    ----;' / | \ `;-<--------- Infraorbital Foramen  ]],
				[[           |__     \__.       \/^\/       .__/                          ]],
				[[              ___   V| \                 / |V <--- Mastoid Process      ]],
				[[              |      | |T~\___!___!___/~T| |                            ]],
				[[              |      | |`IIII_I_I_I_IIII'| |                            ]],
				[[     Mandible |      |  \,III I I I III,/  |                            ]],
				[[              |       \   `~~~~~~~~~~'    /                             ]],
				[[              |         \   .       . <-x---- Mental Foramen            ]],
				[[              |__         \.    ^    ./                                 ]],
				[[                            ^~~~^~~~^                                   ]],
			},
			[2] = {
				[[           .                                                      .          ]],
				[[        .n                   .                 .                  n.         ]],
				[[  .   .dP                  dP                   9b                 9b.    .  ]],
				[[ 4    qXb         .       dX                     Xb       .        dXp     t ]],
				[[dX.    9Xb      .dXb    __                         __    dXb.     dXP     .Xb]],
				[[9XXb._       _.dXXXXb dXXXXbo.                 .odXXXXb dXXXXb._       _.dXXP]],
				[[ 9XXXXXXXXXXXXXXXXXXXVXXXXXXXXOo.           .oOXXXXXXXXVXXXXXXXXXXXXXXXXXXXP ]],
				[[  `9XXXXXXXXXXXXXXXXXXXXX'~   ~`OOO8b   d8OOO'~   ~`XXXXXXXXXXXXXXXXXXXXXP'  ]],
				[[    `9XXXXXXXXXXXP' `9XX'   DIE    `98v8P'  HUMAN   `XXP' `9XXXXXXXXXXXP'    ]],
				[[        ~~~~~~~       9X.          .db|db.          .XP       ~~~~~~~        ]],
				[[                        )b.  .dbo.dP'`v'`9b.odb.  .dX(                       ]],
				[[                      ,dXXXXXXXXXXXb     dXXXXXXXXXXXb.                      ]],
				[[                     dXXXXXXXXXXXP'   .   `9XXXXXXXXXXXb                     ]],
				[[                    dXXXXXXXXXXXXb   d|b   dXXXXXXXXXXXXb                    ]],
				[[                    9XXb'   `XXXXXb.dX|Xb.dXXXXX'   `dXXP                    ]],
				[[                     `'      9XXXXXX(   )XXXXXXP      `'                     ]],
				[[                              XXXX X.`v'.X XXXX                              ]],
				[[                              XP^X'`b   d'`X^XX                              ]],
				[[                              X. 9  `   '  P )X                              ]],
				[[                              `b  `       '  d'                              ]],
				[[                               `             '                               ]],
			},
		}
		dashboard.section.header.val = headers[math.random(0, 30) % 3]

		alpha.setup(dashboard.opts)
	end,
}
