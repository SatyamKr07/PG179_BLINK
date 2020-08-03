import React, { useState } from "react";
import {MDBMask, MDBRow, MDBCol, MDBBtn, MDBView, MDBContainer, MDBCard, MDBCardBody, MDBInput, MDBAnimation } from "mdbreact";
import "./Login.css";
import { auth } from '../../../firebase';
import history from '../../../history';


const Login = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState(null);
    const signInWithEmailAndPasswordHandler = 
            (event, email, password) => {
                event.preventDefault();
                auth.signInWithEmailAndPassword(email, password).then( () => {
                    history.push("/home");
                    //console.log(user.email);
                    //console.log(this.props.user);
                }).catch(error => {
                  setError("Error signing in with password and email!");
                  console.error("Error signing in with password and email", error);
                });
    };
    const onChangeHandler = (event) => {
      const {name, value} = event.currentTarget;
      if(name === 'userEmail') {
          setEmail(value);
      }
      else if(name === 'userPassword'){
        setPassword(value);
      }
    };
    return (
      <div id="classicformpage">
        <MDBView>
          <MDBMask className="d-flex justify-content-center align-items-center gradient">
            <MDBContainer>
              <MDBRow>
                <MDBAnimation
                  type="fadeInLeft"
                  delay=".3s"
                  className="white-text text-center text-md-left col-md-6 mt-xl-5 mb-5"
                >
                  <h1 className="h1-responsive font-weight-bold">
                    WELCOME!
                  </h1>
                  <hr className="hr-light" />
                  <h5 className="mb-4">
                    Welcome back to the Know your Ghats Website.
                    <br />
                    Please login here using your username and password.
                  </h5>
                </MDBAnimation>

                <MDBCol md="6" xl="5" className="mb-4">
                  <MDBAnimation type="fadeInRight" delay=".3s">
                    <MDBCard id="classic-card">
                      <MDBCardBody className="white-text">
                      {error !== null && <div className = "text-center mb-3">{error}</div>}
                        <form className="">
                          <h3 className="text-center">
                            <strong>Login</strong>
                          </h3>
                          
                          <MDBInput
                            className="text white-text"
                            label="E-mail"
                            name="userEmail"
                            value={email}
                            onChange = {(event) => onChangeHandler(event)}
                            type="email"
                          />
                          <MDBInput
                            className="white-text"
                            label="Password"
                            name="userPassword"
                            value={password}
                            onChange = {(event) => onChangeHandler(event)}
                            //icon="lock"
                            type="password"
                          />
                          <div className="text-center mt-4 black-text">
                          <MDBBtn className="rounded-pill" color="purple" onClick = {(event) => {signInWithEmailAndPasswordHandler(event, email, password)}}>
                            Log In
                          </MDBBtn>
                          {/* <button onClick = {(event) => {signInWithEmailAndPasswordHandler(event, email, password)}}>
                              Sign In
                          </button> */}
                            <div className="text-center d-flex justify-content-center white-label">
                              <a href="#!" className="p-2 m-2">
                                <p>Forgot password?</p>
                              </a>
                            </div>
                          </div>
                        </form>
                      </MDBCardBody>
                    </MDBCard>
                  </MDBAnimation>
                </MDBCol>
              </MDBRow>
            </MDBContainer>
          </MDBMask>
        </MDBView>
      </div>
    );
};
    


// const INITIAL_STATE = {
//   email: '',
//   password: '',
//   error: null,
// };

// class LoginFormBase extends Component {
//   constructor(props) {
//     super(props);
//     this.state = { ...INITIAL_STATE };
//   }

//   onSubmit = event => {
//     const { email, password } = this.state;

//     this.props.firebase.doSignInWithEmailAndPassword(email, password).then( () => {
//       this.setState({ ...INITIAL_STATE });
//       this.props.history.push("/home");
//     }).catch( error => {
//       this.setState({ error });
//       console.log(error);
//     });
//     event.preventDefault();
//   };

//   onChange = event => {
//     this.setState({ [event.target.name]: event.target.value });
//   };

//   render() {
//     const { email, password, error } = this.state;

//     const isInvalid = password === '' || email === '';

    
//   }
// }

// const LoginForm = compose(
//   withRouter,
//   withFirebase,
// )(LoginFormBase);

export default Login;

//export { LoginForm };