# Character Switch
### This is a filterscript for SA:MP servers which allows a GTA 5 kind of character switching in-game.#

Steps to install :-

1. Place the CS.pwn into /filterscripts folder.
2. Compile it.
3. Navigate to the root folder and open server.cfg
4. In filterscripts line, add 'CS'
5. You have successfully loaded the Event System now.

Found a bug? Feel free to open an issue here -: https://github.com/Sunehildeep/CharacterSwitch/issues

Usage :-

Press LALT to activate the character switch.

Configuration :-

In order to change skins, edit the CS.pwn and make the changes in the lines below.
#define SKIN1   10
#define SKIN2   50
#define SKIN3   100
#define SKIN4   111

Change those lines above to your needs. And to change the position, head over to the line OnPlayerClickPlayerTextDraw and change the 
SetPlayerPos lines.

Audio soundpacks :-

In order to use the audio soundpack of GTA V, you will need audio plugin for instant starting of audio to make no delay in the sounds.
Download the audiopacks folder and place it in your samp-server directory, and in audio.ini make the following changes.

[default_pack]
1 = dy.wav
2 = screa.wav
3 = eat.wav
4 = pl.wav

Save the file and install the audio client plugin and you're good to go.
