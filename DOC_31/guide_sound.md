*GUIDE SOUND
v 0.0.1



*SOUND BUTTON

boolean sound[ID_item];
>return true if the sound button item is active


int band_length();
> return the num of band spectrum available

boolean transient_is(int index);
>get if there is a transient on a specific section in any situation




*VOLUME

float left[ID_item] ;
>return float value 0 > 1 / 1 when it's the sound is off

float right[ID_item] ;
>return float value 0 > 1 / 1 when it's the sound is off

float mix[ID_item] ;
>return float value 0 > 1 / 1 when it's the sound is off



*Transient > transitory attack, it's close to beat detection

*global transient

float transient_value[0][ID_item] ;
>return float value 1 > 10 or the last value when the sound is off

*section transient 

section 0 is transient_value[1]
section 1 is transient_value[2]
section 2 is transient_value[3]
section 3 is transient_value[4]
We use this system because transient[0] is use for all the range analyze

float transient_value[1][ID_item];
>return float value 1 > 10 / last value when the sound is off

float transient_value[2][ID_item];
>return float value 1 > 10 or thelast value when the sound is off

float transient_value[3][ID_item];
>return float value 1 > 10 or thelast value when the sound is off

float transient_value[4][ID_item];
>return float value 1 > 10 or thelast value when the sound is off

float all_transient(ID_item) ;
>return float value 1 > 12 or thelast value when the sound is off
>Weird because normally the value return must be between 1 to 10 for single value and 1 to 40 for the sum 


*Tempo

tempo[ID_item] @return float value 0 > 1 / 1 when it's the sound is off

tempoBeat[ID_item] @return float value 0 > 1 / 1 when it's the sound is off

tempoKick[ID_item] @return float value 0 > 1 / 1 when it's the sound is off

tempoSnare[ID_item] @return float value 0 > 1 / 1 when it's the sound is off

tempoHat[ID_item] @return float value 0 > 1 / 1 when it's the sound is off



*Track

boolean SOUND_PLAY ; 
>return if there is sound play

float getTimeTrack() ;
>if the track is ON return the time elapse from the beginning play to now, if the track is OFF return value < 0.2



*Band / Spectrum

float band [ID_item][whichBand] ;
>whichBand give the information of the band where catch the info, usualy there is 16 bands, to know the number : bandSpectrum.length ;