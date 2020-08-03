import React from 'react';
import { Router } from "react-router-dom";
import history from "../history";
import {
    MDBNavbar,
    MDBNavbarBrand,
    MDBContainer,
    MDBNavbarNav,
    MDBNavItem,
    MDBNavLink,
    MDBNavbarToggler,
    MDBCollapse
} from "mdbreact";
import {auth} from "../firebase";
import { UserContext } from './providers/UserProvider';

class Header extends React.Component {
    state = {
        collapseID: ""
      };
    
    toggleCollapse = collapseID => () =>
        this.setState(prevState => ({
          collapseID: prevState.collapseID !== collapseID ? collapseID : ""
        }));
    
    render() {
        const overlay = (
          <div
            id="sidenav-overlay"
            style={{ backgroundColor: "transparent" }}
            onClick={this.toggleCollapse("navbarCollapse")}
          />
        );
        return (
            <UserContext.Consumer>
                {(props) => {
                    if(props)
                    {
                        return (
                        <Router history={history}>
                        <div>
                            <MDBNavbar expand="md" >
                            <MDBContainer>
                                <MDBNavbarBrand>
                                <strong className="black-text">KNOW YOUR GHATS</strong>
                                </MDBNavbarBrand>
                                <MDBNavbarToggler
                                onClick={this.toggleCollapse("navbarCollapse")}
                                />
                                <MDBCollapse
                                id="navbarCollapse"
                                isOpen={this.state.collapseID}
                                navbar
                                >
                                    <MDBNavbarNav left>
                                        <MDBNavItem >
                                        <MDBNavLink to="/home"><span className="black-text">Home</span></MDBNavLink>
                                        </MDBNavItem>
                                        <MDBNavItem >
                                            <MDBNavLink to="/createpost"><span className="black-text">Create</span></MDBNavLink>
                                        </MDBNavItem>
                                    </MDBNavbarNav>
                                    <MDBNavbarNav right>
                                        
                                        <MDBNavItem style={{cursor: "pointer"}}  onClick = {() => {auth.signOut().catch(error => {
                              console.error("Error signing out", error);
                            })}}>
                                        <span className="black-text">LogOut</span>
                                        </MDBNavItem>
                                    </MDBNavbarNav>
                                </MDBCollapse>
                            </MDBContainer>
                            </MDBNavbar>
                            {this.state.collapseID && overlay}
                        </div>
                        </Router>
        );
                    } else {
                        return(<div></div>);
                        
                    }
                }}
                
            </UserContext.Consumer>
        );
    }
}

export default Header;