// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";
import "@openzeppelin/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol";

contract DeoniCrowsale1 is Crowdsale {
    using SafeMath for uint256;

    uint256 public _minCap;
    // uint256 public _maxCap;
    // uint256 public _rate;

    mapping(address => uint256) public contributions;

    // Contracts List
    enum CrowdsaleStage {Private1, Private2, Publicsale }
    // Default to presale stage
    CrowdsaleStage public stage = CrowdsaleStage.Private1;

    constructor(
        uint256 minCap,    // Min Contributions
        uint256 rate_,    // rate in TKNbits
        address payable wallet,
        uint256 cap_,
        IERC20 token,
        IERC20 token2
    )
        Crowdsale(rate_, wallet, token, token2, cap_)
    {
        _minCap = minCap;
        _rate = rate_;
        _cap = cap_;
    }

    // Minted Crowd Sale
    function _deliverTokens(address _beneficiary, uint256 _tokenAmount) internal whenNotPaused override {
        ERC20PresetMinterPauser(address(token())).mint(_beneficiary, _tokenAmount);
    }

    function _deliverTokens2(address _beneficiary, uint256 _tokenAmount) internal whenNotPaused override {
        ERC20PresetMinterPauser(address(token2())).mint(_beneficiary, _tokenAmount);
    }

    function Capped() public view virtual returns (uint256) {
        return _cap;
    }

    function getUserContribution(address _beneficiary) public view returns (uint256)
    {
        return contributions[_beneficiary];
    }

    function _preValidatePurchase(address _beneficiary, uint256 _weiAmount) internal whenNotPaused override {
        super._preValidatePurchase(_beneficiary, _weiAmount);
        uint256 _existingContribution = contributions[_beneficiary];
        uint256 _newContribution = _existingContribution.add(_weiAmount);
        require(_newContribution >= _minCap);
        contributions[_beneficiary] = _newContribution;
    }

    // Crowdsale Stages 

    function setCrowdsaleStage(uint _stage, uint256 rate_, uint256 cap_) public onlyOwner {
        if(uint(CrowdsaleStage.Private1) == _stage) {
            stage = CrowdsaleStage.Private1;
        } else if (uint(CrowdsaleStage.Private2) == _stage) {
            stage = CrowdsaleStage.Private2;
        } else if (uint(CrowdsaleStage.Publicsale) == _stage) {
            stage = CrowdsaleStage.Publicsale;
        }

        if(stage == CrowdsaleStage.Private1) {
            _rate = rate_;
            _cap = cap_;
        } else if (stage == CrowdsaleStage.Private2) {
            _rate = rate_;
            _cap = cap_;
        } else if (stage == CrowdsaleStage.Publicsale) {
            _rate = rate_;
            _cap = cap_;
        }
    }

   
    function _forwardFunds() internal override {
        if(stage == CrowdsaleStage.Private1) {
            _wallet.transfer(msg.value);
        } else if (stage == CrowdsaleStage.Private2) {
            _wallet.transfer(msg.value);
        } else if (stage == CrowdsaleStage.Publicsale) {
            super._forwardFunds();
        }
    }

}