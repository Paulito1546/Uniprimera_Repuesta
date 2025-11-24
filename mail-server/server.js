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
    console.log("Serveur prêt à envoyer des mails");
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
      return res.status(500).send('Erreur d’envoi');
    }
    console.log('Email envoyé: ' + info.response);
    res.status(200).send('Mail envoyé');
  });
});

app.listen(port, '0.0.0.0', () => {
  console.log(`Serveur en écoute sur http://0.0.0.0:${port}`);
});