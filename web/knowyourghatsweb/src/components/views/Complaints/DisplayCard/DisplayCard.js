import React from "react";
import { MDBMask, MDBCard, MDBCardBody, MDBIcon, MDBView, MDBBtn } from "mdbreact";
import { Link } from 'react-router-dom';
import "./DisplayCard.css"

const DisplayCard = (props) => {
    return (
        
        <MDBCard style={{border: "none", margin: "10px"}}>
            <MDBCardBody className="text-center">
                <MDBView hover className="rounded mb-4" waves>
                    <img
                        style={{height: "40vh", width: "100%"}}
                        className="img-fluid"
                        src={props.cardVal.image}
                        alt=""
                    />
                    <MDBMask overlay="white-slight" />
                </MDBView>
                <div>
                    <span className="float-left">
                        <MDBIcon icon="heart" style={{padding: 8}}/>
                        {props.cardVal.upvotes.length}
                    </span>   
                    <span className="float-right"  style={{padding: 6}}>
                        {props.cardVal.date}
                    </span>
                </div>
                <br />
                <div className="text-justify text-center">
                    <p style={{marginTop: "20px"}} className="dark-grey-text text-concat">
                        {props.cardVal.review}
                    </p>                                                             
                </div>       
                <Link to={
                    { 
                        pathname: `/complaint/${props.cardVal.id}`,
                        myCustomProps: props.cardVal
                    }} style={{ textDecoration: 'none' }}>
                        <MDBBtn className="float-none" color="purple darken-3" rounded size="md">
                        View more
                        </MDBBtn>
                </Link>            
                
            </MDBCardBody>
        </MDBCard>
    );
}

export default DisplayCard;