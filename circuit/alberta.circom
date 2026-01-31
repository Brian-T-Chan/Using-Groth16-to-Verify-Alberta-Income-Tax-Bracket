pragma circom 2.0.0;

include "comparators.circom";

template AlbertaIncomeBracket() {

    // Input signals in cents
    signal input employment_income;
    signal input self_employment_income;
    signal input rental_income;
    signal input investment_income;
    signal input pension_or_retirement_income;
    signal input other_taxable_benefits;
    signal input rrsp_contributions;
    signal input union_professional_dues;
    signal input childcare_expenses;
    signal input moving_expenses;
    signal input business_or_employment_expenses;
    signal input support_payments;
    
    // The bracket (1-5)
    signal input bracket;
    
    // Internal signals
    signal gross_income;
    signal deductions;
    signal taxable_income;
    
    // Thresholds for Alberta tax brackets (2023) in cents
    signal threshold1 <== 13122000;
    signal threshold2 <== 15746400;
    signal threshold3 <== 20995200;
    signal threshold4 <== 31492800;
    
    gross_income <== employment_income +
                     self_employment_income +
                     rental_income +
                     investment_income +
                     pension_or_retirement_income +
                     other_taxable_benefits;
    
    deductions <== rrsp_contributions +
                   union_professional_dues +
                   childcare_expenses +
                   moving_expenses +
                   business_or_employment_expenses +
                   support_payments;

    // Check if gross_income >= deductions (valid case)
    // geCheck.out is 1 if gross_income >= deductions, 0 otherwise
    component geCheck = GreaterEqThan(64); // Assuming 64-bit numbers
    geCheck.in[0] <== gross_income;
    geCheck.in[1] <== deductions;
    geCheck.out === 1;

    // Determine expected bracket
    taxable_income <== gross_income - deductions;
    
    component ge5 = GreaterEqThan(64);
    ge5.in[0] <== taxable_income;
    ge5.in[1] <== threshold4;
    
    component ge4 = GreaterEqThan(64);
    ge4.in[0] <== taxable_income;
    ge4.in[1] <== threshold3;
    
    component ge3 = GreaterEqThan(64);
    ge3.in[0] <== taxable_income;
    ge3.in[1] <== threshold2;
    
    component ge2 = GreaterEqThan(64);
    ge2.in[0] <== taxable_income;
    ge2.in[1] <== threshold1;
    
    signal expected_bracket;
    expected_bracket <== 5 * ge5.out + 
                    4 * (ge4.out - ge5.out) + 
                    3 * (ge3.out - ge4.out) + 
                    2 * (ge2.out - ge3.out) + 
                    1 * (1 - ge2.out);
    
    // Checks to see whether the input bracket matches the computed bracket.
    bracket === expected_bracket;
}


component main { public [bracket] } = AlbertaIncomeBracket();
