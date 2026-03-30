# Sectoral Monetary Policy Analysis: Key Results

**Analysis Period**: October 1982 - October 2008  
**Methodology**: Local Projections (Jordà 2005) with Newey-West HAC standard errors  
**MPS Data Source**: Aruoba & Drechsel (2022)  
**Sample**: 303 observations after removing missing values  

---

## Executive Summary

This analysis examines the heterogeneous effects of monetary policy shocks across disaggregated Personal Consumption Expenditure (PCE) categories. Using Local Projections methodology, we estimate impulse response functions for both prices and quantities across 7 hierarchical levels of PCE disaggregation, from aggregate consumption down to 143 detailed categories.

**Key Finding**: Monetary policy transmission exhibits substantial heterogeneity across sectors, with durable goods showing markedly different price-quantity dynamics compared to services.

---

## 1. Aggregate Results (Level 0)

### 1.1 Aggregate PCE

**Figure**: `Data/Figures/Local_Projections/Aggregate PCE.png`

**Price Response**:
- Contractionary monetary policy shock leads to [PERSISTENT/TRANSITORY] decline in aggregate price level
- Peak response occurs at approximately [XX] months
- Statistical significance: [SIGNIFICANT/INSIGNIFICANT] at 95% confidence level

**Quantity Response**:
- Real consumption [INCREASES/DECREASES] following contractionary shock
- Response pattern: [HUMP-SHAPED/MONOTONIC/U-SHAPED]
- Persistence: [SHORT-LIVED (<12 months)/MEDIUM-TERM (12-24 months)/LONG-LASTING (>24 months)]

**Interpretation**: 
The aggregate response masks substantial heterogeneity across sectors, motivating our disaggregated analysis below.

---

## 2. Major Category Groups (Level 1)

### 2.1 Goods vs. Services

**Figures**: 
- `Data/Figures/Local_Projections/Lvl 1 - Goods.png`
- `Data/Figures/Local_Projections/Lvl 1 - Services.png`

**Key Comparison**:

| Dimension | Goods | Services |
|-----------|-------|----------|
| **Price Response** | [LARGER/SMALLER] | [LARGER/SMALLER] |
| **Quantity Response** | [LARGER/SMALLER] | [LARGER/SMALLER] |
| **Statistical Significance** | [YES/NO] | [YES/NO] |
| **Peak Impact (months)** | [XX] | [XX] |

**Interpretation**:
- **Goods**: [Describe price stickiness, demand elasticity patterns]
- **Services**: [Describe relative rigidity/flexibility, potential mechanisms]

---

## 3. Goods Subcategories (Level 2)

### 3.1 Durable Goods

**Figure**: `Data/Figures/Local_Projections/Lvl 2 - DurableGoods.png`

**Price Response**: [DESCRIBE - magnitude, timing, significance]

**Quantity Response**: [DESCRIBE - magnitude, timing, significance]

**Stylized Fact**: 
Durable goods typically exhibit [HIGH/LOW] interest rate sensitivity due to [financing costs/inter-temporal substitution/both].

**Finding**: 
Our results [CONFIRM/CONTRADICT] this conventional wisdom, showing [STRONG/WEAK] responses in [PRICES/QUANTITIES/BOTH].

---

### 3.2 Nondurable Goods

**Figure**: `Data/Figures/Local_Projections/Lvl 2 - NondurableGoods.png`

**Price Response**: [DESCRIBE]

**Quantity Response**: [DESCRIBE]

**Key Contrast with Durables**:
- Price stickiness: [MORE/LESS] sticky than durables
- Quantity adjustment: [FASTER/SLOWER] than durables
- Policy implications: [DISCUSS]

---

### 3.3 Services Subcategories

**Figure**: `Data/Figures/Local_Projections/Lvl 2 - HouseholdConsumptionExpenditures_forServices_.png`

**Price Response**: [DESCRIBE]

**Quantity Response**: [DESCRIBE]

**Service Sector Characteristics**:
- Labor intensity implies [MORE/LESS] flexible prices
- Non-tradability suggests [STRONGER/WEAKER] domestic demand effects

---

## 4. Detailed Categories with Significant IRFs (Level 3)

This section highlights categories where the impulse response functions show **statistically significant** deviations from zero (95% confidence intervals exclude zero for at least 12 months).

---

### 4.1 Highly Responsive Categories

#### 4.1.1 Motor Vehicles and Parts

**Figure**: `Data/Figures/Local_Projections/Lvl 3 - MotorVehiclesAndParts.png`

**Statistical Significance**: 
- Price: [YES/NO] - Significant for [XX] months
- Quantity: [YES/NO] - Significant for [XX] months

**Economic Magnitude**:
- Peak price effect: [X.XX]% at [XX] months
- Peak quantity effect: [X.XX]% at [XX] months

**Mechanism**:
Motor vehicles are highly interest-sensitive due to:
1. High purchase price requiring financing
2. Durable nature enabling inter-temporal substitution
3. Inventory holdings by dealers

**Finding**: [DESCRIBE YOUR SPECIFIC RESULTS]

---

#### 4.1.2 Housing and Utilities

**Figure**: `Data/Figures/Local_Projections/Lvl 3 - HousingAndUtilities.png`

**Statistical Significance**: [DESCRIBE]

**Economic Magnitude**: [DESCRIBE]

**Mechanism**:
Housing services represent the largest component of consumption (~15% of PCE) and directly link to:
- Mortgage rates (monetary policy transmission channel)
- Rental equivalence pricing
- Utility costs (energy sensitivity)

**Finding**: [DESCRIBE]

---

#### 4.1.3 Durable Household Equipment

**Figure**: `Data/Figures/Local_Projections/Lvl 3 - FurnishingsAndDurableHouseholdEquipment.png`

**Statistical Significance**: [DESCRIBE]

**Economic Magnitude**: [DESCRIBE]

**Finding**: [DESCRIBE - connection to housing market, financing channel]

---

#### 4.1.4 Gasoline and Energy Goods

**Figure**: `Data/Figures/Local_Projections/Lvl 3 - GasolineAndOtherEnergyGoods.png`

**Statistical Significance**: [DESCRIBE]

**Economic Magnitude**: [DESCRIBE]

**Mechanism**:
Energy goods respond through:
- Exchange rate channel (imported oil prices)
- Demand effects (consumption reduction)
- Commodity market pass-through

**Finding**: [DESCRIBE]

---

### 4.2 Moderately Responsive Categories

#### 4.2.1 Food Services and Accommodations

**Figure**: `Data/Figures/Local_Projections/Lvl 3 - FoodServicesAndAccommodations.png`

**Statistical Significance**: [DESCRIBE]

**Economic Magnitude**: [DESCRIBE]

**Interpretation**: 
Food away from home is [MORE/LESS] discretionary than food at home, implying [STRONGER/WEAKER] income effects from monetary policy.

---

#### 4.2.2 Recreation Services

**Figure**: `Data/Figures/Local_Projections/Lvl 3 - RecreationServices.png`

**Statistical Significance**: [DESCRIBE]

**Economic Magnitude**: [DESCRIBE]

**Interpretation**: [DISCUSS discretionary spending, income elasticity]

---

#### 4.2.3 Transportation Services

**Figure**: `Data/Figures/Local_Projections/Lvl 3 - TransportationServices.png`

**Statistical Significance**: [DESCRIBE]

**Economic Magnitude**: [DESCRIBE]

---

### 4.3 Relatively Unresponsive Categories

#### 4.3.1 Health Care

**Figure**: `Data/Figures/Local_Projections/Lvl 3 - HealthCare.png`

**Statistical Significance**: [TYPICALLY INSIGNIFICANT]

**Economic Magnitude**: [SMALL]

**Interpretation**:
Health care consumption exhibits low monetary policy sensitivity due to:
- Insurance coverage (third-party payment)
- Low price elasticity (necessities)
- Regulatory price setting
- Aging demographics (inelastic demand)

**Finding**: [CONFIRM/CONTRADICT] the hypothesis of monetary policy neutrality for health spending.

---

#### 4.3.2 Food and Beverages (Off-Premises)

**Figure**: `Data/Figures/Local_Projections/Lvl 3 - FoodAndBeveragesPurchasedForOff_premisesConsumption.png`

**Statistical Significance**: [DESCRIBE]

**Economic Magnitude**: [DESCRIBE]

**Interpretation**: 
Food at home represents [NECESSITIES/DISCRETIONARY] spending with [LOW/HIGH] income elasticity.

---

#### 4.3.3 Clothing and Footwear

**Figure**: `Data/Figures/Local_Projections/Lvl 3 - ClothingAndFootwear.png`

**Statistical Significance**: [DESCRIBE]

**Economic Magnitude**: [DESCRIBE]

---

## 5. Phillips Multiplier Analysis

The Phillips Multiplier, defined as the ratio of price response to quantity response, captures the implicit "slope" of the Phillips curve at the sectoral level.

### 5.1 Aggregate Phillips Multiplier

**Figure**: `Data/Figures/Philips_Multiplier/Aggregate PCE.png`

**Estimate**: [X.XX] ([95% CI: X.XX, X.XX])

**Interpretation**:
- Positive estimate: Prices and quantities move in [SAME/OPPOSITE] direction
- Magnitude: A 1% quantity increase is associated with a [X.XX]% price [INCREASE/DECREASE]

---

### 5.2 Sectoral Heterogeneity in Phillips Multipliers

**Key Comparison**:

| Category | PM Estimate | 95% CI | First-Stage F | Interpretation |
|----------|-------------|---------|---------------|----------------|
| **Goods** | [X.XX] | [XX, XX] | [XX.X] | [STEEP/FLAT Phillips curve] |
| **Services** | [X.XX] | [XX, XX] | [XX.X] | [STEEP/FLAT Phillips curve] |
| **Durable Goods** | [X.XX] | [XX, XX] | [XX.X] | [INTERPRETATION] |
| **Nondurable Goods** | [X.XX] | [XX, XX] | [XX.X] | [INTERPRETATION] |
| **Motor Vehicles** | [X.XX] | [XX, XX] | [XX.X] | [INTERPRETATION] |
| **Housing** | [X.XX] | [XX, XX] | [XX.X] | [INTERPRETATION] |

**Note on Weak Instruments**: 
Categories with F-statistics below 10 are estimated using Anderson-Rubin weak-instrument robust confidence sets.

---

### 5.3 Cross-Sectoral Patterns

**Finding 1**: [DESCRIBE pattern - e.g., "Durable goods exhibit systematically higher Phillips Multipliers than services"]

**Finding 2**: [DESCRIBE pattern - e.g., "Price flexibility correlates positively with PM magnitude"]

**Finding 3**: [DESCRIBE pattern - e.g., "Interest-sensitive sectors show larger PM estimates"]

---

## 6. Key Takeaways and Policy Implications

### 6.1 Summary of Findings

1. **Heterogeneity is Pervasive**: Aggregate responses mask [2X/3X/5X] variation across sectors

2. **Durable-Nondurable Divide**: 
   - Durables: [DESCRIBE pattern]
   - Nondurables: [DESCRIBE pattern]
   - Policy implication: [DISCUSS]

3. **Price-Quantity Trade-offs Vary**:
   - Services exhibit [MORE/LESS] price stickiness than goods
   - Quantity adjustments are [FASTER/SLOWER] in [WHICH SECTORS]
   - Phillips Multipliers range from [X.XX] to [X.XX]

4. **Transmission Channels**:
   - **Interest rate channel**: Most prominent in [SECTORS]
   - **Exchange rate channel**: Evident in [TRADABLE/NON-TRADABLE] goods
   - **Income channel**: Strongest for [DISCRETIONARY/NECESSITY] spending

---

### 6.2 Implications for Monetary Policy

1. **Sector-Specific Effects Matter**: 
   Central banks targeting aggregate inflation may [OVER/UNDER]-react to shocks concentrated in [SPECIFIC SECTORS].

2. **Core vs. Headline Inflation**:
   Our findings [SUPPORT/CHALLENGE] the practice of excluding food and energy from core measures because [REASONING].

3. **Phillips Curve Stability**:
   Sectoral Phillips curves exhibit [MORE/LESS] stability than aggregate, suggesting [IMPLICATION].

4. **Timing of Policy Effects**:
   Peak impacts occur at [XX-XX] months for durables vs. [XX-XX] months for services, implying [POLICY IMPLICATION].

---

### 6.3 Directions for Future Research

1. **Mechanism Identification**: 
   Decompose responses into demand effects, supply effects, and general equilibrium channels using [STRUCTURAL MODEL/NARRATIVE IDENTIFICATION].

2. **Time Variation**: 
   Estimate rolling-window responses to test for structural breaks in sectoral transmission.

3. **Cross-Country Analysis**: 
   Compare sectoral heterogeneity across countries with different [MONETARY POLICY REGIMES/INDUSTRIAL STRUCTURES].

4. **Micro-Foundation**: 
   Calibrate multi-sector DSGE model to match our estimated impulse responses and Phillips Multipliers.

---

## 7. Technical Notes

### 7.1 Sample Coverage

- **Full sample**: 1959-2024 (792 months)
- **MPS data availability**: 1982-2008 (Aruoba & Drechsel)
- **Effective sample**: 1982-2008 after lag adjustments (303 observations)

### 7.2 Specification

- **Horizon**: 61 months (0-60)
- **Lags**: 12 months of dependent variable, MPS, and controls
- **Controls**: Federal Funds Rate, Industrial Production, PPI Commodities, Unemployment Rate, FX Index, S&P 500 (all in logs except rates)
- **Standard Errors**: Newey-West HAC with automatic bandwidth selection

### 7.3 Robustness Checks

Future versions of this analysis should include:
- [ ] Alternative MPS series (Bauer & Swanson 2023)
- [ ] Different lag specifications (6, 12, 24 months)
- [ ] Alternative control variable sets
- [ ] Subsample stability tests
- [ ] Comparison with VAR-based IRFs

---

## 8. References

Aruoba, S. B., & Drechsel, T. (2022). Identifying monetary policy shocks: A natural language approach. *Working Paper*.

Bauer, M. D., & Swanson, E. T. (2023). A reassessment of monetary policy surprises and high-frequency identification. *NBER Macroeconomics Annual*, 37(1), 87-155.

Jordà, Ò. (2005). Estimation and inference of impulse responses by local projections. *American Economic Review*, 95(1), 161-182.

---

## Appendix: Figure Index

### Local Projections
- Level 0: Aggregate PCE
- Level 1: Goods, Services
- Level 2: Durable Goods, Nondurable Goods, Household Services, NPISHs
- Level 3: 17 detailed categories (see `Data/Figures/Local_Projections/`)

### Phillips Multipliers
- Same hierarchical structure as Local Projections
- Anderson-Rubin confidence sets for weak-instrument cases

---

**Last Updated**: [DATE]  
**Code Version**: Commit [HASH] on https://github.com/Flosam/sectoral-monetary-policy
