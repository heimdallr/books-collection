function toggleTheme() {
	let theme = document.getElementById('theme');
	if (theme.getAttribute('href') == '../css/style2.css') {
		theme.setAttribute('href', '../css/style1.css');
	} 
	else {
		theme.setAttribute('href', '../css/style2.css');
	}
}
