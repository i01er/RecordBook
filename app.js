const express = require('express');
const app = express();
const bodyParser = require('body-parser')

	app.use(express.static(__dirname + '/public'));
    app.use(bodyParser.urlencoded({ extended: true }));
    // parse application/json
    // app.use(bodyParser.json());

app.get('/',(req, res) =>
{
	res.sendFile(__dirname + '/public/index.html');
});

app.listen(3000);
