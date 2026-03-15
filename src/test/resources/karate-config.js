 function fn() {

   var config = {};
   config.headers = {
     'Content-Type': 'text/xml; charset=utf-8'
   };
   config.endpoints = {
     add: 'http://tempuri.org/Add',
     divide: 'http://tempuri.org/Divide'

   };

   // environnement
   var env = karate.env;
   if (!env) {
     env = 'dev';
   }

   // URLs centralisées
   if (env == 'dev') {
     config.baseUrl = 'http://www.dneonline.com/calculator.asmx';
   }

   if (env == 'qa') {
     config.baseUrl = 'http://qa-server/calculator.asmx';
   }

   if (env == 'prod') {
     config.baseUrl = 'http://prod-server/calculator.asmx';
   }

   return config;
 }