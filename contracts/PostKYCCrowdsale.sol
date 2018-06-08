pragma solidity 0.4.24;

import "../zeppelin/ownership/Ownable.sol";
import "../zeppelin/crowdsale/Crowdsale.sol";


/// @title PostKYCCrowdsale
/// @author Autogenerated from a Dia UML diagram
contract PostKYCCrowdsale is Crowdsale, Ownable {

    struct Investment {
        bool isVerified;  // wether or not the investor passed the KYC process
        uint weiAmount;   // invested wei
        uint tokenAmount; // amount of token quantums the investor wants to purchase
    }

    mapping(address => Investment) public investments;

    /// @dev Log entry on investor verified
    /// @param investor An Ethereum address
    event InvestorVerified(address investor);

    /// @dev Log entry on tokens delivered
    /// @param investor An Ethereum address
    /// @param amount A positive number
    event TokensDelivered(address investor, uint amount);

    /// @dev Log entry on withdrawn
    /// @param investor An Ethereum address
    /// @param value A positive number
    event Withdrawn(address investor, uint value);

    /// @dev Verify investors
    /// @param _investors An Ethereum address
    function verifyInvestors(address[] _investors) public onlyOwner {
        for (uint i = 0; i < _investors.length; ++i) {
            address investor = _investors[i];
            Investment storage investment = investments[investor];

            if (!investment.isVerified) {
                investment.isVerified = true;

                emit InvestorVerified(investor);

                uint weiAmount = investment.weiAmount;
                uint tokenAmount = investment.tokenAmount;

                if (weiAmount > 0) {
                    investment.weiAmount = 0;
                    investment.tokenAmount = 0;

                    _forwardFunds(weiAmount);
                    _deliverTokens(investor, tokenAmount);

                    emit TokensDelivered(investor, tokenAmount);
                }
            }
        }
    }

    /// @dev Withdraw
    function withdraw() public {
        Investment storage investment = investments[msg.sender];
        uint weiAmount = investment.weiAmount;

        require(weiAmount > 0);

        investment.weiAmount = 0;
        investment.tokenAmount = 0;

        msg.sender.transfer(weiAmount);

        emit Withdrawn(msg.sender, weiAmount);
    }

    /// @dev Pre validate purchase
    /// @param _beneficiary An Ethereum address
    /// @param _weiAmount A positive number
    function _preValidatePurchase(address _beneficiary, uint _weiAmount) internal {
        require(_beneficiary == msg.sender);

        super._preValidatePurchase(_beneficiary, _weiAmount);
    }

    /// @dev Process purchase
    // @param _beneficiary An Ethereum address
    /// @param _tokenAmount A positive number
    function _processPurchase(address, uint _tokenAmount) internal {
        if (investments[msg.sender].isVerified) {
            _deliverTokens(msg.sender, _tokenAmount);

            emit TokensDelivered(msg.sender, _tokenAmount);
        } else {
            investments[msg.sender].weiAmount = msg.value;
            investments[msg.sender].tokenAmount = _tokenAmount;
        }
    }

    /// @dev Forward funds
    function _forwardFunds() internal {
        if (investments[msg.sender].isVerified) {
            super._forwardFunds();
        }
    }

    /// @dev Forward funds
    /// @param _weiAmount A positive number
    function _forwardFunds(uint _weiAmount) internal {
        wallet.transfer(_weiAmount);
    }

}
