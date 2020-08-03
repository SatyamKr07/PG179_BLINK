import React from 'react';
import ReactDOM from 'react-dom';
import '@fortawesome/fontawesome-free/css/all.min.css'; 
import 'bootstrap-css-only/css/bootstrap.min.css';
//import 'mdbreact/dist/css/mdb.css';
import "./assets/scss/mdb-free.scss";
import App from './components/App';
//import Firebase, { FirebaseContext } from './Firebase';

ReactDOM.render(<App />,document.querySelector('#root'));