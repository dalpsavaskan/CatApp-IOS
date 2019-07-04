const express = require('express')
const app = express()
const port = 3000



var kitten0= {
kittenId:0,
kittenName:"Cupcake",
kittenColor:"Pink",
kittenSex:"Female",
kittenAge:2,
kittenLoveliness:10,
kittenWildness:1
};
var kitten1= {
kittenId:1,
kittenName:"Mooncake",
kittenColor:"Green",
kittenSex:"Male",
kittenAge:100,
kittenLoveliness:10,
kittenWildness:1
};
var kitten2= {
kittenId:2,
kittenName:"Stray cat",
kittenColor:"Grey",
kittenSex:"Male",
kittenAge:1,
kittenLoveliness:2,
kittenWildness:8
};
var kitten3= {
kittenId:3,
kittenName:"Cosmos",
kittenColor:"Black",
kittenSex:"Male",
kittenAge:200,
kittenLoveliness:10,
kittenWildness:10
};
var kitten4= {
kittenId:4,
kittenName:"Cheesecake",
kittenColor:"Yellow",
kittenSex:"Female",
kittenAge:6,
kittenLoveliness:6,
kittenWildness:2
};
var kitten5= {
kittenId:5,
kittenName:"Princess",
kittenColor:"White",
kittenSex:"Female",
kittenAge:4,
kittenLoveliness:9,
kittenWildness:7
};


var kittenArrayList= [kitten0,kitten1,kitten2,kitten3,kitten4,kitten5]
app.get('/', (req, res) => res.send(kittenArrayList))
app.get('/0/', (req, res) => res.send(kitten0))
app.get('/1/', (req, res) => res.send(kitten1))
app.get('/2/', (req, res) => res.send(kitten2))
app.get('/3/', (req, res) => res.send(kitten3))
app.get('/4/', (req, res) => res.send(kitten4))
app.get('/5/', (req, res) => res.send(kitten5))


app.listen(port, () => console.log(`Example app listening on port ${port}!`))
