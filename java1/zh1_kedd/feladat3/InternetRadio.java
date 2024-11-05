interface InternetRadio {

	/**
		Plays an advertisment
		
		@param length: length of the ad, in seconds
	*/
	void playAdvertisment(float length);
	
	/**
		Plays a music
		
		@param title: Title of the music to play
		@param artist: Artist of the music to play
	*/
	void playMusic(String title, String artist);
	
	/**
		Check if an ad is currently being played
		
		@returns true, if an ad is playing right now
	*/
	boolean isAdPlaying();
}