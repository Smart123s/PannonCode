var express = require('express');
var router = express.Router();

var Sequelize = require('sequelize');
const DataTypes = Sequelize.DataTypes;

const sequelize = new Sequelize('sqlite::%TEMP%/test.sqlite');
const Color = sequelize.define('Color', {
  color: DataTypes.STRING,
});
const User = sequelize.define('User', {
  name: DataTypes.STRING,
  age: DataTypes.NUMBER,
  student: DataTypes.BOOLEAN,
  working: DataTypes.BOOLEAN,
  gender: DataTypes.BOOLEAN,
  color: DataTypes.STRING,
});

// create tables
Color.sync({ force: true });
User.sync({ force: true });

/* GET home page. */
router.get('/', async function(req, res, next) {
  res.render('index', { colors: await Color.findAll() });
});

router.get('/add_color', async function(req, res, next) {
  await Color.create({
    color: req.query.color,
  });
  res.redirect("/");
});

router.get('/add_user', async function(req, res, next) {
  await User.create({
    name: req.query.name,
    age: req.query.age,
    student: req.query.student == 'on',
    working: req.query.working == 'on',
    gender: req.query.gender,
    color: req.query.color,
  });
  res.redirect("/");
});

router.get('/get_users', async function(req, res, next) {
  const users = await User.findAll();
  res.send(JSON.stringify(users, null, 2));
});

module.exports = router;
