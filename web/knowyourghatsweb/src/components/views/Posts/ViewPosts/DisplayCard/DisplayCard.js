import React from "react";
import { MDBCard, MDBCardBody, MDBView } from "mdbreact";
import { Link } from 'react-router-dom';
import "./DisplayCard.css"

const DisplayCard = (props) => {
    return (
        <Link to={
            { 
                pathname: `/viewpost/${props.cardVal.id}`,
                myCustomProps: props.cardVal
            }} style={{ textDecoration: 'none' }}>
            <MDBCard waves className="hoverable z-depth-1" style={{ marginBottom: "40px"}}>
                <MDBCardBody className="text-center">
                    <MDBView hover className="rounded" waves>
                        <img
                            style={{height: "40vh", width: "100%"}}
                            className="img-fluid"
                            src={props.cardVal.image}
                            alt=""
                        />
                        
                    </MDBView>
                    <br /> 
                    <div className="text-justify text-center">
                        <p style={{marginBottom: "15px", fontSize: "1.4rem"}} className="black-text">
                            {props.cardVal.title}
                        </p>                                                             
                    </div>       
                </MDBCardBody>
            </MDBCard>
        </Link>  
    );
}

export default DisplayCard;