#include <a_samp>
#include <dialogs>
#include <zcmd>

// Defini��es //
#define DialogSelectSkinCategory    17010
#define DialogSelectSkin            17011


// Categorias
#define CATEGORIA_GANG       	1
#define CATEGORIA_PUBLICA    	2
#define CATEGORIA_NAMORADAS  	3
#define CATEGORIA_PRAIA     	4
#define CATEGORIA_CAIPIRAS      5
#define CATEGORIA_PROSTITUTAS   6
#define CATEGORIA_TRABALHOS     7
#define CATEGORIA_HOTCOFFE      8
#define CATEGORIA_CUSTOM        9
#define CATEGORIA_OUTROS        10


// Vari�veis
enum esk {
	SkinCategory,
	SkinModel
};
static PlayerData[MAX_PLAYERS][esk];

static const SkinIDs[][esk] =
{
	{CATEGORIA_GANG, 105},{CATEGORIA_GANG, 106},{CATEGORIA_GANG, 107}, // Grove Street
	{CATEGORIA_GANG, 102},{CATEGORIA_GANG, 103},{CATEGORIA_GANG, 104}, // Ballas
	{CATEGORIA_GANG, 114},{CATEGORIA_GANG, 115},{CATEGORIA_GANG, 116}, // LosAztecas
	{CATEGORIA_GANG, 108},{CATEGORIA_GANG, 109},{CATEGORIA_GANG, 110}, // Los Vagos
	{CATEGORIA_GANG, 121},{CATEGORIA_GANG, 122},{CATEGORIA_GANG, 123}, // Da Nang Boys
	{CATEGORIA_GANG, 173},{CATEGORIA_GANG, 174},{CATEGORIA_GANG, 175}, // San Fierro Rifa
	{CATEGORIA_GANG, 117},{CATEGORIA_GANG, 118},{CATEGORIA_GANG, 120}, // Tr�ades
	{CATEGORIA_GANG, 247},{CATEGORIA_GANG, 248},{CATEGORIA_GANG, 254}, // Ciclistas
	{CATEGORIA_GANG, 111},{CATEGORIA_GANG, 112},{CATEGORIA_GANG, 113}, // M�fia Russa
	{CATEGORIA_GANG, 124},{CATEGORIA_GANG, 125},{CATEGORIA_GANG, 126},{CATEGORIA_GANG, 127}, // M�fia Italiana
	//////////////////////////////////////////////////////////////////////
	{CATEGORIA_PUBLICA, 165},{CATEGORIA_PUBLICA, 166}, // MIB Agent
	{CATEGORIA_PUBLICA, 280},{CATEGORIA_PUBLICA, 281},{CATEGORIA_PUBLICA, 282}, // Pol�cia LS/SF/LV
	{CATEGORIA_PUBLICA, 283},{CATEGORIA_PUBLICA, 288},// Pol�cia do Campo
	{CATEGORIA_PUBLICA, 284},{CATEGORIA_PUBLICA, 287},// Policial Motoqueiro/Militar
	{CATEGORIA_PUBLICA, 285},{CATEGORIA_PUBLICA, 286},//SWAT/FBI
	// Outras skins de Pol�cia
	{CATEGORIA_PUBLICA, 300},{CATEGORIA_PUBLICA, 301},{CATEGORIA_PUBLICA, 302},
	{CATEGORIA_PUBLICA, 306},{CATEGORIA_PUBLICA, 307},{CATEGORIA_PUBLICA, 309},// Feminina
	{CATEGORIA_PUBLICA, 310},{CATEGORIA_PUBLICA, 311},
	{CATEGORIA_PUBLICA, 277},{CATEGORIA_PUBLICA, 278},{CATEGORIA_PUBLICA, 279},// Bombeiros
	{CATEGORIA_PUBLICA, 274},{CATEGORIA_PUBLICA, 275},{CATEGORIA_PUBLICA, 276},{CATEGORIA_PUBLICA, 308},//Param�dico
	{CATEGORIA_PUBLICA, 164},{CATEGORIA_PUBLICA, 165},//Seguran�a
	////////////////////////////////////////////////////////////////////////////////
	{CATEGORIA_NAMORADAS, 190},{CATEGORIA_NAMORADAS, 191},{CATEGORIA_NAMORADAS, 192},
	{CATEGORIA_NAMORADAS, 193},{CATEGORIA_NAMORADAS, 194},{CATEGORIA_NAMORADAS, 195},
	////////////////////////////////////////////////////////////////////////////////
	{CATEGORIA_PRAIA, 18},{CATEGORIA_PRAIA, 45},{CATEGORIA_PRAIA, 192},{CATEGORIA_PRAIA, 97},
	{CATEGORIA_PRAIA, 138},{CATEGORIA_PRAIA, 139},{CATEGORIA_PRAIA, 140},{CATEGORIA_PRAIA, 145},
	{CATEGORIA_PRAIA, 146},{CATEGORIA_PRAIA, 154},{CATEGORIA_PRAIA, 251},
	////////////////////////////////////////////////////////////////////////////////
	{CATEGORIA_CAIPIRAS, 31},{CATEGORIA_CAIPIRAS, 32},{CATEGORIA_CAIPIRAS, 33},{CATEGORIA_CAIPIRAS, 34},
	{CATEGORIA_CAIPIRAS, 128},{CATEGORIA_CAIPIRAS, 129},{CATEGORIA_CAIPIRAS, 130},{CATEGORIA_CAIPIRAS, 131},
	{CATEGORIA_CAIPIRAS, 132},{CATEGORIA_CAIPIRAS, 133},{CATEGORIA_CAIPIRAS, 157},{CATEGORIA_CAIPIRAS, 158},
	{CATEGORIA_CAIPIRAS, 159},{CATEGORIA_CAIPIRAS, 160},{CATEGORIA_CAIPIRAS, 161},{CATEGORIA_CAIPIRAS, 162},
	{CATEGORIA_CAIPIRAS, 196},{CATEGORIA_CAIPIRAS, 197},{CATEGORIA_CAIPIRAS, 198},{CATEGORIA_CAIPIRAS, 199},
	{CATEGORIA_CAIPIRAS, 200},{CATEGORIA_CAIPIRAS, 201},{CATEGORIA_CAIPIRAS, 202},
	/////////////////////////////////////////////////////////////////////////////////
	{CATEGORIA_PROSTITUTAS, 63},{CATEGORIA_PROSTITUTAS, 64},{CATEGORIA_PROSTITUTAS, 85},{CATEGORIA_PROSTITUTAS, 87},
	{CATEGORIA_PROSTITUTAS, 152},{CATEGORIA_PROSTITUTAS, 178},{CATEGORIA_PROSTITUTAS, 207},{CATEGORIA_PROSTITUTAS, 237},
	{CATEGORIA_PROSTITUTAS, 238},{CATEGORIA_PROSTITUTAS, 243},{CATEGORIA_PROSTITUTAS, 244},{CATEGORIA_PROSTITUTAS, 245},
	{CATEGORIA_PROSTITUTAS, 246},{CATEGORIA_PROSTITUTAS, 256},{CATEGORIA_PROSTITUTAS, 257},
	//////////////////////////////////////////////////////////////////////////////////
	{CATEGORIA_OUTROS, 23},{CATEGORIA_OUTROS, 26},{CATEGORIA_OUTROS, 51},{CATEGORIA_OUTROS, 52},
	{CATEGORIA_OUTROS, 80},{CATEGORIA_OUTROS, 81},{CATEGORIA_OUTROS, 90},{CATEGORIA_OUTROS, 96},
	{CATEGORIA_OUTROS, 99},{CATEGORIA_OUTROS, 258},{CATEGORIA_OUTROS, 259},
	//////////////////////////////////////////////////////////////////////////////////
	{CATEGORIA_TRABALHOS, 11},{CATEGORIA_TRABALHOS, 16},{CATEGORIA_TRABALHOS, 27},{CATEGORIA_TRABALHOS, 68},
	{CATEGORIA_TRABALHOS, 70},{CATEGORIA_TRABALHOS, 71},{CATEGORIA_TRABALHOS, 141},{CATEGORIA_TRABALHOS, 147},
	{CATEGORIA_TRABALHOS, 148},{CATEGORIA_TRABALHOS, 150},{CATEGORIA_TRABALHOS, 153},{CATEGORIA_TRABALHOS, 155},
	{CATEGORIA_TRABALHOS, 167},{CATEGORIA_TRABALHOS, 171},{CATEGORIA_TRABALHOS, 172},{CATEGORIA_TRABALHOS, 176},
	{CATEGORIA_TRABALHOS, 177},{CATEGORIA_TRABALHOS, 179},{CATEGORIA_TRABALHOS, 187},{CATEGORIA_TRABALHOS, 189},
	{CATEGORIA_TRABALHOS, 203},{CATEGORIA_TRABALHOS, 204},{CATEGORIA_TRABALHOS, 205},{CATEGORIA_TRABALHOS, 209},
	{CATEGORIA_TRABALHOS, 211},{CATEGORIA_TRABALHOS, 217},{CATEGORIA_TRABALHOS, 219},{CATEGORIA_TRABALHOS, 260},
	{CATEGORIA_TRABALHOS, 264},
	/////////////////////////////////////////////////////////////////////////////////
	{CATEGORIA_OUTROS, 29},{CATEGORIA_OUTROS, 30},{CATEGORIA_OUTROS, 49},{CATEGORIA_OUTROS, 50},
	{CATEGORIA_OUTROS, 57},{CATEGORIA_OUTROS, 61},{CATEGORIA_OUTROS, 62},{CATEGORIA_OUTROS, 66},
	{CATEGORIA_OUTROS, 73},{CATEGORIA_OUTROS, 77},{CATEGORIA_OUTROS, 78},{CATEGORIA_OUTROS, 79},
	{CATEGORIA_OUTROS, 82},{CATEGORIA_OUTROS, 83},{CATEGORIA_OUTROS, 84},{CATEGORIA_OUTROS, 134},
	{CATEGORIA_OUTROS, 135},{CATEGORIA_OUTROS, 137},{CATEGORIA_OUTROS, 181},{CATEGORIA_OUTROS, 212},
	{CATEGORIA_OUTROS, 213},{CATEGORIA_OUTROS, 224},{CATEGORIA_OUTROS, 230},{CATEGORIA_OUTROS, 239},
	{CATEGORIA_OUTROS, 241},{CATEGORIA_OUTROS, 242},{CATEGORIA_OUTROS, 249},{CATEGORIA_OUTROS, 252},
	{CATEGORIA_OUTROS, 253},{CATEGORIA_OUTROS, 255},
	/////////////////////////////////////////////////////////////////////////////////
	{CATEGORIA_HOTCOFFE, 21011},{CATEGORIA_HOTCOFFE, 21012},{CATEGORIA_HOTCOFFE, 21013},
	{CATEGORIA_HOTCOFFE, 21014},{CATEGORIA_HOTCOFFE, 21015},{CATEGORIA_HOTCOFFE, 21016},
	{CATEGORIA_HOTCOFFE, 21017},{CATEGORIA_HOTCOFFE, 21018},{CATEGORIA_HOTCOFFE, 21019},
	{CATEGORIA_HOTCOFFE, 21020},{CATEGORIA_HOTCOFFE, 21021},
	/////////////////////////////////////////////////////////////////////////////////
	{CATEGORIA_CUSTOM, 20001},{CATEGORIA_CUSTOM, 20002},{CATEGORIA_CUSTOM, 20003},{CATEGORIA_CUSTOM, 20004},
	{CATEGORIA_CUSTOM, 20005},{CATEGORIA_CUSTOM, 20006},{CATEGORIA_CUSTOM, 20007},{CATEGORIA_CUSTOM, 20008},
	{CATEGORIA_CUSTOM, 20009},{CATEGORIA_CUSTOM, 20010},{CATEGORIA_CUSTOM, 20011},{CATEGORIA_CUSTOM, 20012},
	{CATEGORIA_CUSTOM, 20013},{CATEGORIA_CUSTOM, 20014},{CATEGORIA_CUSTOM, 20015},{CATEGORIA_CUSTOM, 20016},
	{CATEGORIA_CUSTOM, 20017},{CATEGORIA_CUSTOM, 20018},{CATEGORIA_CUSTOM, 20019},{CATEGORIA_CUSTOM, 20020},
	{CATEGORIA_CUSTOM, 20021},{CATEGORIA_CUSTOM, 20022},{CATEGORIA_CUSTOM, 20023},{CATEGORIA_CUSTOM, 20024},
	{CATEGORIA_CUSTOM, 20025},{CATEGORIA_CUSTOM, 20026},{CATEGORIA_CUSTOM, 20027},{CATEGORIA_CUSTOM, 20028},
	{CATEGORIA_CUSTOM, 20029},{CATEGORIA_CUSTOM, 20030},{CATEGORIA_CUSTOM, 20100},{CATEGORIA_CUSTOM, 20101},
	{CATEGORIA_CUSTOM, 20110},{CATEGORIA_CUSTOM, 20111}
	/////////////////////////////////////////////////////////////////////////////////
};

public OnFilterScriptInit() return print("Seletor de Skin by Locky");


public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid) {
		case DialogSelectSkinCategory: {
			if(!response) return 1;
			return SetTimerEx("MostrarSkins", 2000, false, "dd", playerid, listitem);
		}
		case DialogSelectSkin: {
		    if(!response) return 1;
		    new indx;
		    for(new i; i < sizeof(SkinIDs); i++) {
			    if(SkinIDs[i][SkinCategory] == PlayerData[playerid][SkinCategory]) {
			        if(listitem == indx) {
			            SetPlayerSkin(playerid, (PlayerData[playerid][SkinModel] = SkinIDs[i][SkinModel]));
			            break;
					}
					else indx++;
				}
			}
		    return 1;
		}
	}
	return 1;
}
forward MostrarSkins(playerid, listitem);
public MostrarSkins(playerid, listitem) {
	new cat = PlayerData[playerid][SkinCategory] = listitem + 1,
	str[1000];
	for(new i; i < sizeof(SkinIDs); i++) {
	    if(SkinIDs[i][SkinCategory] == cat) {
	        format(str, sizeof(str), "%s%i\t%i\n", str, SkinIDs[i][SkinModel], SkinIDs[i][SkinModel]);
		}
	}
	return ShowPlayerDialog(playerid, DialogSelectSkin, DIALOG_STYLE_PREVMODEL, "~g~#~w~Skins", str, "Selecionar", "Cancelar");
}

// Comandos //
CMD:skin(playerid, params[]) {
	if(!isnull(params)) return cmd_setskin(playerid, params);
	return ShowPlayerDialog(playerid, DialogSelectSkinCategory, DIALOG_STYLE_PREVMODEL, "~r~#~w~ Skin: Categoria", "107\tGangs\n280\tServicos Publicos\n192\tNamoradas do CJ\n45\tPraia\n34\tCaipiras\n152\tProstitutas\n153\tTrabalhos\n21021\tHot Coffe\n20019\tCustom\n20100\tOutras\n", "Selecionar", "Cancelar");
}

CMD:setskin(playerid, params[]) return SetPlayerSkin(playerid, strval(params));
