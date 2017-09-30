AddCSLuaFile()
if CLIENT then

local vars =
{

	font = "TargetID",

	padding = 10,
	margin = 35,

	text_spacing = 2,
	bar_spacing = 5,

	bar_height = 16,

	width = 0.15

};

local colors =
{

	background =
	{

		border = Color( 0, 182, 219, 150 ),
		background = Color( 0, 182, 219, 75 )

	},

	text =
	{

		shadow = Color( 0, 0, 0, 200 ),
		text = Color( 255, 255, 255, 255 )

	},

	health_bar =
	{

		border = Color( 255, 0, 0, 255 ),
		background = Color( 255, 0, 0, 75 ),
		shade = Color( 255, 104, 104, 255 ),
		fill = Color( 232, 0, 0, 255 )

	},

	suit_bar =
	{

		border = Color( 0, 0, 255, 255 ),
		background = Color( 0, 0, 255, 75 ),
		shade = Color( 136, 136, 255, 255 ),
		fill = Color( 0, 0, 219, 255 )

	},
		tokens =
	{

		shadow = Color( 0, 100, 0, 200 ),
		text = Color( 150, 255, 255, 255 )

	}

};


local function HUDPaint( )

	client = client or LocalPlayer( );				
	if( !client:Alive( ) ) then return; end			
	local _, th = good_hud:TextSize( "TEXT", vars.font );		

	local i = 6;							-- shortcut to how many items( bars + text ) we have

	local width = vars.width * ScrW( );				
	local bar_width = width - ( vars.padding * i );			
	local height = ( vars.padding * i ) + ( th * i ) + ( vars.text_spacing * i ) + ( vars.bar_height * i ) + vars.bar_spacing;

	local x = vars.margin;						
	local y = ScrH( ) - vars.margin - height;			

	local cx = x + vars.padding;					
	local cy = y + vars.padding;

	good_hud:PaintPanel( x, y, width, height, colors.background );

	local by = th + vars.text_spacing;				

	local text = string.format( "Health: %iHP", client:Health( ) );	
	good_hud:PaintText( cx, cy, text, vars.font, colors.text );	
	good_hud:PaintBar( cx, cy + by, bar_width, vars.bar_height, colors.health_bar, client:Health( ) / 100 );

	by = by + vars.bar_height + vars.bar_spacing;
	local text = string.format( "Suit: %iSP", client:Armor( ) );	
	good_hud:PaintText( cx, cy + by, text, vars.font, colors.text );	
	good_hud:PaintBar( cx, cy + by + th + vars.text_spacing, bar_width, vars.bar_height, colors.suit_bar, client:Armor( ) / 100 );

	by = by + vars.bar_height + vars.bar_spacing;
	by = by + vars.bar_height + vars.bar_spacing;			
	by = by + vars.bar_height + vars.bar_spacing;			
	local text = string.format( "Cash: %i$", LocalPlayer():GetXp() );	
	good_hud:PaintText( cx, cy + by, text, vars.font, colors.text );	

	by = by + vars.bar_height + vars.bar_spacing;			
	by = by + vars.bar_height + vars.bar_spacing;			
	local text = string.format( "Tokens: %i", LocalPlayer():GetToken() );
	good_hud:PaintText( cx, cy + by, text, vars.font, colors.tokens );	
	
	by = by + vars.bar_height + vars.bar_spacing;			
	by = by + vars.bar_height + vars.bar_spacing;			
	local text = string.format( "Killed: %i", LocalPlayer():GetNWInt("killcounter") );	
	good_hud:PaintText( cx, cy + by, text, vars.font, colors.text );	
	by = by + vars.bar_height + vars.bar_spacing;			
	by = by + vars.bar_height + vars.bar_spacing;			
	local text = string.format( "Spawned: %i", LocalPlayer():Frags() );	
	good_hud:PaintText( cx, cy + by, text, vars.font, colors.text );	

end
hook.Add( "HUDPaint", "PaintOurHud", HUDPaint );

good_hud = { };

local function clr( color ) return color.r, color.g, color.b, color.a; end

function good_hud:PaintBar( x, y, w, h, colors, value )

	self:PaintPanel( x, y, w, h, colors );

	x = x + 1; y = y + 1;
	w = w - 2; h = h - 2;

	local width = w * math.Clamp( value, 0, 1 );
	local shade = 4;

	surface.SetDrawColor( clr( colors.shade ) );
	surface.DrawRect( x, y, width, shade );

	surface.SetDrawColor( clr( colors.fill ) );
	surface.DrawRect( x, y + shade, width, h - shade );

end

function good_hud:PaintPanel( x, y, w, h, colors )

	surface.SetDrawColor( clr( colors.border ) );
	surface.DrawOutlinedRect( x, y, w, h );

	x = x + 1; y = y + 1;
	w = w - 2; h = h - 2;

	surface.SetDrawColor( clr( colors.background ) );
	surface.DrawRect( x, y, w, h );

end

function good_hud:PaintText( x, y, text, font, colors )

	surface.SetFont( font );

	surface.SetTextPos( x + 1, y + 1 );
	surface.SetTextColor( clr( colors.shadow ) );
	surface.DrawText( text );

	surface.SetTextPos( x, y );
	surface.SetTextColor( clr( colors.text ) );
	surface.DrawText( text );

end

function good_hud:TextSize( text, font )

	surface.SetFont( font );
	return surface.GetTextSize( text );

end
end
