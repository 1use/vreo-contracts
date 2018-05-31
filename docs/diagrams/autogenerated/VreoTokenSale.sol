pragma solidity 0.4.23;

import "FinalizableCrowdsale.sol";
import "MintedCrowdsale.sol";
import "./VreoTokenBounty.sol";


/// @title VreoTokenSale
/// @author Autogenerated from a Dia UML diagram
contract VreoTokenSale is FinalizableCrowdsale, MintedCrowdsale {

    struct Investor {
        bool validated; // wether or not the investor passed the KYC process
        uint amount; // amount of token quantums the investor wants to purchase
        uint value; // invested wei
    }

    uint public TOTAL_TOKEN_CAP = 450000000e18; // = 450.000.000 e18
    uint public TEAM_TOKEN_SHARE = 85000000e18; // =  85.000.000 e18
    uint public ADVISORS_TOKEN_SHARE = 58000000e18; // =  58.000.000 e18
    uint public LEGAL_TOKEN_SHARE = 57000000e18; // =  57.000.000 e18
    uint public BOUNTY_TOKEN_SHARE = 50000000e18; // =  50.000.000 e18
    VreoTokenBounty public bounty;
    mapping(address => Investor) public investors;

    /// @dev Log entry on rate changed
    /// @param newRate A positive number
    event RateChanged(uint newRate);

    /// @dev Log entry on investor validated
    /// @param investor An Ethereum address
    event InvestorValidated(address investor);

    /// @dev Log entry on investor invalidated
    /// @param investor An Ethereum address
    event InvestorInvalidated(address investor);

    /// @dev Log entry on withdrawn
    /// @param investor An Ethereum address
    /// @param amount A positive number
    /// @param value A positive number
    event Withdrawn(address investor, uint amount, uint value);

    /// @dev Constructor
    /// @param _token A VreoToken
    /// @param _openingTime A positive number
    /// @param _closingTime A positive number
    /// @param _rate A positive number
    /// @param _bounty A VreoTokenBounty
    /// @param _wallet An Ethereum address
    constructor(VreoToken _token, uint _openingTime, uint _closingTime, uint _rate, VreoTokenBounty _bounty, address _wallet) public Crowdsale(_rate, _wallet, _token) TimedCrowdsale(_openingTime, _closingTime) {
        require(IMPLEMENTATION);
    }

    /// @dev Set rate
    /// @param _newRate A positive number
    function setRate(uint _newRate) public onlyOwner {
        require(IMPLEMENTATION);
    }

    /// @dev Validate investor
    /// @param _investor An Ethereum address
    function validateInvestor(address _investor) public onlyOwner {
        require(IMPLEMENTATION);
    }

    /// @dev Invalidate investor
    /// @param _investor An Ethereum address
    function invalidateInvestor(address _investor) public onlyOwner {
        require(IMPLEMENTATION);
    }

    /// @dev Buy tokens
    /// @param _beneficiary An Ethereum address
    function buyTokens(address _beneficiary) public payable {
        require(IMPLEMENTATION);
    }

    /// @dev Withdraw
    function withdraw() public {
        require(IMPLEMENTATION);
    }

    /// @dev Pre validate purchase
    /// @param _beneficiary An Ethereum address
    /// @param _weiAmount A positive number
    function _preValidatePurchase(address _beneficiary, uint _weiAmount) internal {
        require(IMPLEMENTATION);
    }

    /// @dev Post validate purchase
    /// @param _beneficiary An Ethereum address
    /// @param _weiAmount A positive number
    function _postValidatePurchase(address _beneficiary, uint _weiAmount) internal {
        require(IMPLEMENTATION);
    }

    /// @dev Deliver tokens
    /// @param _beneficiary An Ethereum address
    /// @param _tokenAmount A positive number
    function _deliverTokens(address _beneficiary, uint _tokenAmount) internal {
        require(IMPLEMENTATION);
    }

    /// @dev Process purchase
    /// @param _beneficiary An Ethereum address
    /// @param _tokenAmount A positive number
    function _processPurchase(address _beneficiary, uint _tokenAmount) internal {
        require(IMPLEMENTATION);
    }

    /// @dev Update purchasing state
    /// @param _beneficiary An Ethereum address
    /// @param _weiAmount A positive number
    function _updatePurchasingState(address _beneficiary, uint _weiAmount) internal {
        require(IMPLEMENTATION);
    }

    /// @dev Get token amount
    /// @param _weiAmount A positive number
    /// @return A positive number
    function _getTokenAmount(uint _weiAmount) internal view returns (uint) {
        require(IMPLEMENTATION);
    }

    /// @dev Forward funds
    function _forwardFunds() internal {
        require(IMPLEMENTATION);
    }

    /// @dev Finalization
    function finalization() internal {
        require(IMPLEMENTATION);
    }

}
