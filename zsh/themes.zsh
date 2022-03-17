# Functions

candy(){

	candy_git() {
    	if git rev-parse --git-dir > /dev/null 2>&1; then
    		echo "%F{#06d6a0}%K{#06d6a0} %F{#121212}%f Master %k%F{#06d6a0}%f"
    	fi
		}

	echo -ne "%B%F{#ffadad}%K{#ffadad} %f%F{#121212}%n %F{#ffadad}%k%K{#ffd6a5}%f %F{#121212}%m %k%F{#ffd6a5}%K{#bdb2ff}%f %F{#121212}%~ %k%F{#bdb2ff}%f$(candy_git)"; echo " \n:: "
}

icecream(){
	echo -ne "%F{#d8e2dc}%K{#d8e2dc} %F{#121212}%~%f %k%F{#d8e2dc}%f "
}

simple(){
	echo -ne "%B%F{#00FF80}%~ %F{#889011}::%f "
}

colorise(){
	rd="%B%F{$((RANDOM % 100))}"

	echo "${rd}┌[%f%n${rd}]%f
${rd}└[%f%~${rd}]%f "
}

here(){
	rd="%B%F{$((RANDOM % 100))}"
	echo -ne "%F{#06d6a0}%f [%F{#06d6a0}%~%f] "
}

happy(){
	echo -ne "%F{#ccee11}ツ%f Wellcome $USER: "
}