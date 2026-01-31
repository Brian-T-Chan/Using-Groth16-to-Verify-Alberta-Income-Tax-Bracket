
# All input types should be non-negative integers and all amounts should be in cents.
# Outputs 1 to 5 represent tax brackets, where 1 represents the lowest tax bracket and
# 5 represents the highest tax bracket.
# Output is 0 if gross income is less than deductions.

def alberta_income_bracket(employment_income,
                   self_employment_income,
                   rental_income,
                   investment_income,
                   pension_or_retirement_income,
                   other_taxable_benefits,
                   rrsp_contributions,
                   union_professional_dues,
                   childcare_expenses,
                   moving_expenses,
                   business_or_employment_expenses,
                   support_payments):

    gross_income = (
        employment_income +
        self_employment_income +
        rental_income +
        investment_income +
        pension_or_retirement_income +
        other_taxable_benefits
    )

    deductions = (
        rrsp_contributions +
        union_professional_dues +
        childcare_expenses +
        moving_expenses +
        business_or_employment_expenses +
        support_payments
    )

    if gross_income < deductions:
        return False

    taxable_income = gross_income - deductions

    # Thresholds for Alberta tax brackets (2023) in cents
    thresholds = [0, 13122000, 15746400, 20995200, 31492800]

    number_of_brackets = 5

    for i in range(number_of_brackets - 1):
        if taxable_income >= thresholds[i] and taxable_income < thresholds[i+1]:
            return i+1

    return 5


