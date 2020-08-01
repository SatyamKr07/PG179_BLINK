import React from "react";
import {  Link } from "react-router-dom";
import {  MDBRow, MDBCol,  MDBContainer, MDBBtn, MDBBtnGroup } from "mdbreact";
import homeImg from "../../../images/home2.jpg";
import "./Home.css";

const Home = () => {
    return (
        <MDBContainer id="home" fluid>
            <MDBRow>
                <MDBCol style={{padding: 0}}>
                    <img
                        style={{height: "100%", width: "100%"}}
                        className="img-fluid"
                        src={homeImg}
                        alt=""
                    />
                </MDBCol>
                <MDBCol>
                    <div style={{position: 'absolute', left: '50%', top: '50%',
        transform: 'translate(-50%, -50%)'}}>
                        <div className="text-center">
                        <p id="head">
                                KNOW YOUR GHATS
                        </p>
                        <h5>
                            <p>
                                Review the new places added by the users and address their problems through the website.
                            </p>
                        </h5>
                        <MDBBtnGroup vertical>
                            <Link to={{ pathname: "/newplaces"}} style={{ textDecoration: 'none' }}>
                                <MDBBtn style={{marginBottom: "30px"}}>
                                    Review New Places
                                </MDBBtn>
                            </Link>
                            <Link to={{ pathname: "/complaints"}} style={{ textDecoration: 'none' }}>
                                <MDBBtn>
                                    Review Complaints
                                </MDBBtn>
                            </Link>
                        </MDBBtnGroup>
                        </div>
                        
                    </div>           
                </MDBCol>
            </MDBRow>
        </MDBContainer>
    );
};

export default Home;