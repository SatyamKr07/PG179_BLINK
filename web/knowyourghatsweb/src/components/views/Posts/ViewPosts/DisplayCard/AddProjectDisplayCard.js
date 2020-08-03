import React from "react";
import { MDBCard, MDBCardBody, MDBView } from "mdbreact";
import { Link } from 'react-router-dom';
import "./DisplayCard.css"

const AddProjectDisplayCard = (props) => {
    return (
        <Link to={
            { 
                pathname: "/createpost",
                myCustomProps: props.cardVal
            }} style={{ textDecoration: 'none' }}>
            <MDBCard waves className="hoverable z-depth-1" style={{ marginBottom: "40px"}}>
                <MDBCardBody className="text-center">
                    <MDBView hover className="rounded" waves>
                        <img
                            style={{height: "40vh", width: "100%"}}
                            className="img-fluid"
                            src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/9e/Plus_symbol.svg/1200px-Plus_symbol.svg.png"
                            alt=""
                        />
                        
                    </MDBView>
                    <br /> 
                    <div className="text-justify text-center">
                        <p style={{marginBottom: "15px", fontSize: "1.4rem"}} className="black-text">
                            ADD NEW PROJECT
                        </p>                                                             
                    </div>       
                </MDBCardBody>
            </MDBCard>
        </Link>  
    );
}

export default AddProjectDisplayCard;