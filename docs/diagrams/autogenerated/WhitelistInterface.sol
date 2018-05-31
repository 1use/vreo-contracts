pragma solidity 0.4.24;


/// @title WhitelistInterface
/// @author Autogenerated from a Dia UML diagram
interface WhitelistInterface {

    /// @dev Is whitelisted
    /// @param _account An Ethereum address
    /// @return True or false
    function isWhitelisted(address _account) external view returns (bool);

}

