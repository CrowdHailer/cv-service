var github_path = 'http://gitcv.herokuapp.com/' + gon.github_username;
console.log(github_path);
$.get(github_path, function(data) {
	$('#cv-service-container').append(data);
});

