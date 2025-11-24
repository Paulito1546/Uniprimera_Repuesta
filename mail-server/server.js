const express = require('express');
const nodemailer = require('nodemailer');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;

app.use(bodyParser.json());

// Configure ton compte Gmail/SMTP ici (ou autre fournisseur)
const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'paul.emptoz@gmail.com',
    pass: 'zhdk cjhv jhfv lzrx'
  }
});

transporter.verify(function(error, success) {
  if (error) {
    console.log(error);
  } else {
    console.log("Servidor listo para enviar correos electrónicos");
  }
});

app.post('/sendmail', (req, res) => {
  const { to, subject, text } = req.body;

  const mailOptions = {
    from: 'paul.emptoz@gmail.com',
    to : 'paul.emptoz@gmail.com',
    subject,
    text
  };

  transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
      console.log(error);
      return res.status(500).send('Error al enviar');
    }
    console.log('Correo electrónico enviado: ' + info.response);
    res.status(200).send('Correo enviado');
  });
});

app.listen(port, '0.0.0.0', () => {
  console.log(`Servidor a la escucha en http://0.0.0.0:${port}`);
});