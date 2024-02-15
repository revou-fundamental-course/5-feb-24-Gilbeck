document.addEventListener('DOMContentLoaded', function() {
    const convertButton = document.getElementById('convertButton');
    const resetButton = document.getElementById('resetButton');
    const reverseButton = document.getElementById('reverseButton');
    const tempInput = document.getElementById('tempInput');
    const unitSelect = document.getElementById('unitSelect');
    const conversionResult = document.getElementById('conversionResult');

    convertButton.addEventListener('click', function() {
        const inputTemp = parseFloat(tempInput.value);
        const selectedUnit = unitSelect.value;
        
        if (!isNaN(inputTemp)) {
            let result;
            let convertedUnit;
            if (selectedUnit === 'celsius') {
                result = (inputTemp * 9/5) + 32;
                convertedUnit = 'Fahrenheit';
            } else {
                result = (inputTemp - 32) * 5/9;
                convertedUnit = 'Celsius';
            }

            conversionResult.innerHTML = `${inputTemp} ${selectedUnit} is equal to ${result.toFixed(2)} ${convertedUnit}.`;
        } else {
            conversionResult.innerHTML = 'Please enter a valid temperature.';
        }
    });

    resetButton.addEventListener('click', function() {
        tempInput.value = '';
        conversionResult.innerHTML = '';
    });

    reverseButton.addEventListener('click', function() {
        const inputTemp = parseFloat(tempInput.value);
        if (!isNaN(inputTemp)) {
            if (unitSelect.value === 'celsius') {
                unitSelect.value = 'fahrenheit';
            } else {
                unitSelect.value = 'celsius';
            }
            convertButton.click(); // Trigger conversion
        }
    });
});
