pragma solidity 0.4.24;

import "../node_modules/zeppelin-solidity/contracts/ownership/Ownable.sol";
import "../node_modules/zeppelin-solidity/contracts/crowdsale/Crowdsale.sol";


/// @title PostKYCCrowdsale
/// @author Sicos et al.
contract PostKYCCrowdsale is Crowdsale, Ownable {

    struct Investment {
        bool isVerified;         // wether or not the investor passed the KYC process
        uint totalWeiInvested;   // invested wei
        uint pendingTokenAmount; // amount of token quantums the investor wants to purchase
    }

    mapping(address => Investment) public investments;

    /// @dev Log entry on investor verified
    /// @param investor the investor's Ethereum address
    event InvestorVerified(address investor);

    /// @dev Log entry on tokens delivered
    /// @param investor the investor's Ethereum address
    /// @param amount A positive number
    event TokensDelivered(address investor, uint amount);

    /// @dev Log entry on investment withdrawn
    /// @param investor the investor's Ethereum address
    /// @param value A positive number
    event InvestmentWithdrawn(address investor, uint value);

    /// @dev Verify investors
    /// @param _investors list of investors' Ethereum addresses
    function verifyInvestors(address[] _investors) public onlyOwner {
        for (uint i = 0; i < _investors.length; ++i) {
            address investor = _investors[i];
            Investment storage investment = investments[investor];

            if (!investment.isVerified) {
                investment.isVerified = true;

                emit InvestorVerified(investor);

                uint pendingTokenAmount = investment.pendingTokenAmount;

                if (pendingTokenAmount > 0) {
                    investment.pendingTokenAmount = 0;

                    _forwardFunds(investment.totalWeiInvested);
                    _deliverTokens(investor, pendingTokenAmount);

                   emit TokensDelivered(investor, pendingTokenAmount);
                }
            }
        }
    }

    /// @dev Withdraw investment
    /// @dev Investors that are not verified can withdraw their funds
    function withdrawInvestment() public {
        Investment storage investment = investments[msg.sender];

        require(!investment.isVerified);

        uint totalWeiInvested = investment.totalWeiInvested;

        require(totalWeiInvested > 0);

        investment.totalWeiInvested = 0;
        investment.pendingTokenAmount = 0;

        msg.sender.transfer(totalWeiInvested);

        emit InvestmentWithdrawn(msg.sender, totalWeiInvested);
    }

    /// @dev Pre validate purchase
    /// @param _beneficiary An Ethereum address
    /// @param _weiAmount A positive number
    function _preValidatePurchase(address _beneficiary, uint _weiAmount) internal {
        require(_beneficiary == msg.sender);

        super._preValidatePurchase(_beneficiary, _weiAmount);
    }

    /// @dev Process purchase
    /// @param _beneficiary An Ethereum address
    /// @param _tokenAmount A positive number
    function _processPurchase(address _beneficiary, uint _tokenAmount) internal {
        Investment storage investment = investments[msg.sender];
        investment.totalWeiInvested = investment.totalWeiInvested.add(msg.value);

        // If the investors KYC is already verified we issue the tokens imediatly
        if (investment.isVerified) {
            _deliverTokens(_beneficiary, _tokenAmount);
            emit TokensDelivered(_beneficiary, _tokenAmount);
        }
        // If the investors KYC is not verified we store the pending token amount
        else {
            investment.pendingTokenAmount = investment.pendingTokenAmount.add(_tokenAmount);
        }
    }

    /// @dev Forward funds
    function _forwardFunds() internal {
        // Ensure the investor was verified, i.e. his purchased tokens were delivered,
        // before forwarding funds.
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
