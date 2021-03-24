// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

pragma solidity 0.7.6;

import "../Pool.sol";

contract TPool is Pool {

    bool _repricing = true;

    constructor(
        address _derivativeVault,
        address _dynamicFee,
        address _repricer,
        uint _baseFee,
        uint _maxFee,
        uint _feeAmp,
        address _controller
    )
    public Pool(_derivativeVault, _dynamicFee, _repricer, _baseFee, _maxFee, _feeAmp, _controller)
    { }

    function resetTokenRecordTo(
        address token,
        uint balance,
        uint leverage
    )
    external
    {
        Record storage record = _records[token];
        record.balance = balance;
        record.leverage = leverage;
    }

    function turnOffRepricing()
    external
    {
        _repricing = false;
    }

    function reprice()
    internal override
    {
        if(_repricing) {
            super.reprice();
        }
    }
}
