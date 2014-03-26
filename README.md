cv-serivce
==========

This repo is for a microservice to deliver Curriculum Vitae Repos from github.
The service offers a restful API for accessing CV's of the form

```
service.com/<github username>
```

Use
===
1. Include a target element with id cv-service-container
2. Make available github username on the JS variable gon.github_username
3. Include JavaScript tag below (requires JQuery)

```html
<script type="text/javascript" src="http://gitcv.herokuapp.com/fetchcv.js"></script>
```

Parsing
=======
CV's are parsed using the Redcarpet Ruby Gem
