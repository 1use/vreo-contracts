pragma solidity 0.4.24;

import "Ownable.sol";
import "./VreoToken.sol";


/// @title VreoTokenBounty
/// @author Autogenerated from a Dia UML diagram
contract VreoTokenBounty is Ownable {

    VreoToken public token;

    /// @dev Log entry on token distributed
    /// @param recipient An Ethereum address
    /// @param amount A positive number
    event TokenDistributed(address recipient, uint amount);

    /// @dev Constructor
    /// @param _token A VreoToken
    constructor(VreoToken _token) public {
        require(IMPLEMENTATION);
    }

    /// @dev Distribute tokens
    /// @param _recipients A list where each entry is an Ethereum address
    /// @param _amounts A list where each entry is a positive number
    function distributeTokens(address[] _recipients, uint[] _amounts) public onlyOwner {
        require(IMPLEMENTATION);
    }

}

