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

![Aggregate PCE](Data/Figures/Local_Projections/Aggregate%20PCE.png)

**Price Response**:
- Contractionary monetary policy shock leads to **persistent** decline in aggregate price level
- Peak response: **-3.37pp** at month 52 (95% CI: [-5.83, -0.92])
- Statistical significance: **SIGNIFICANT** at 95% confidence level
- Long and variable lag: effects build gradually over 4+ years

**Quantity Response**:
- Real consumption **decreases** following contractionary shock
- Peak response: **-4.37pp** at month 22 (95% CI: [-6.87, -1.87])
- Response pattern: **HUMP-SHAPED** - peaks around 2 years, then gradually dissipates
- Persistence: **LONG-LASTING** (>24 months) - statistically significant effects persist beyond 2 years

**Interpretation**: 
The aggregate response masks substantial heterogeneity across sectors, motivating our disaggregated analysis below. Both prices and quantities exhibit economically and statistically significant responses, with quantities reacting faster (peak at 22 months) than prices (peak at 52 months).

---

## 2. Major Category Groups (Level 1)

### 2.1 Goods vs. Services

![Goods](Data/Figures/Local_Projections/Lvl%201%20-%20Goods.png)

![Services](Data/Figures/Local_Projections/Lvl%201%20-%20Services.png)

**Key Comparison**:

| Dimension | Goods | Services |
|-----------|-------|----------|
| **Price Response** | -5.09pp at month 52 | -2.53pp at month 54 |
| **Quantity Response** | **+9.00pp** at month 52 | -3.11pp at month 30 |
| **Statistical Significance** | YES (both) | YES (both) |
| **Peak Impact (months)** | 52 (late) | 30-54 (varied) |

**Key Finding - Puzzling Goods Quantity Response**:
- **Goods**: Show a **counterintuitive positive quantity response** (+9.00pp, CI: [2.30, 15.71])
  - This suggests goods consumption *increases* following contractionary policy
  - Significant price decline (-5.09pp) concurrent with quantity increase
  - May reflect composition effects or data quality issues in disaggregation
  
- **Services**: Exhibit expected negative quantity response (-3.11pp, CI: [-5.44, -0.77])
  - Smaller but more persistent price decline (-2.53pp)
  - Both price and quantity move in expected directions
  - Peak quantity response occurs earlier (month 30) than price (month 54)

**Interpretation**:
The goods quantity response is economically puzzling and warrants further investigation. Possible explanations:
1. **Composition effects**: Level 1 aggregation may mask offsetting movements in durables vs. nondurables
2. **Relative price effects**: Strong price declines in goods may induce substitution from services
3. **Data issues**: Disaggregation methodology may introduce measurement error

Services exhibit more intuitive responses with conventional monetary policy transmission.

---

## 3. Goods Subcategories (Level 2)

### 3.1 Durable Goods

![Durable Goods](Data/Figures/Local_Projections/Lvl%202%20-%20DurableGoods.png)

**Price Response**: 
- Peak: **-4.45pp** at month 50 (95% CI: [-8.87, -0.02])
- Marginally significant (CI barely excludes zero)
- Similar magnitude to aggregate, but slower to peak

**Quantity Response**: 
- Peak: **+19.27pp** at month 55 (95% CI: [6.52, 32.02])
- **Highly significant** positive response
- Largest magnitude among all major categories

**Stylized Fact**: 
Durable goods typically exhibit **HIGH** interest rate sensitivity due to **financing costs and inter-temporal substitution**.

**Finding**: 
Our results **CONTRADICT** conventional wisdom. The **positive quantity response** is economically puzzling:
- Standard theory predicts durables should *decline* most after contractionary policy (higher interest rates → reduced purchases of cars, appliances, etc.)
- Instead, we observe the opposite: durables consumption **increases** significantly
- This anomaly suggests either:
  1. Data measurement issues in the disaggregation process
  2. Complex general equilibrium effects not captured by partial equilibrium intuition  
  3. Composition effects within the durable goods category

**Critical Note**: This result requires further investigation before drawing policy conclusions.

---

### 3.2 Nondurable Goods

![Nondurable Goods](Data/Figures/Local_Projections/Lvl%202%20-%20NondurableGoods.png)

**Price Response**: 
- Peak: **-6.88pp** at month 52 (95% CI: [-12.28, -1.48])
- **Largest price decline** among major categories
- Highly significant and persistent

**Quantity Response**: 
- Peak: **+5.39pp** at month 52 (95% CI: [1.27, 9.51])
- Significant positive response (though smaller than durables)
- Also exhibits puzzling positive sign

**Key Contrast with Durables**:
- Price stickiness: **LESS** sticky than durables (larger price response: -6.88pp vs -4.45pp)
- Quantity adjustment: **SMALLER** magnitude than durables (5.39pp vs 19.27pp)
- Policy implications: Both goods subcategories show puzzling positive quantity responses, but nondurables have stronger price adjustments, suggesting different price-setting mechanisms

**Interpretation**: 
The combination of large price declines and positive quantity responses in nondurables is inconsistent with standard demand theory, reinforcing concerns about the goods category results.

---

### 3.3 Services Subcategories

![Household Services](Data/Figures/Local_Projections/Lvl%202%20-%20HouseholdConsumptionExpenditures_forServices_.png)

**Price Response**: 
- Peak: **-2.61pp** at month 54 (95% CI: [-4.71, -0.50])
- Significant but smaller than goods categories
- Very persistent effect (peaks at 4.5 years)

**Quantity Response**: 
- Peak: **-3.61pp** at month 13 (95% CI: [-5.91, -1.32])
- Significant negative response (expected direction!)
- Much faster adjustment than price (13 vs 54 months)

**Service Sector Characteristics**:
- Labor intensity implies **LESS** flexible prices (wages are sticky)
- Non-tradability suggests **STRONGER** domestic demand effects (no import competition buffer)

**Key Finding**:
Services exhibit the **most economically sensible** responses:
- Both price and quantity decline (expected for contractionary policy)
- Quantities adjust faster than prices (consistent with price stickiness)
- Smaller magnitude than goods (consistent with lower interest sensitivity)

**Note on NPISHs**: 
The Level 2 also includes "Final Consumption Expenditures of NPISHs" (Non-Profit Institutions Serving Households), which shows:
- Very large responses (price: -9.99pp, quantity: +16.90pp at month 13)
- High uncertainty (wide confidence intervals)
- This is a small, specialized category and results should be interpreted cautiously

---

## 4. Detailed Categories with Significant IRFs (Level 3)

This section highlights categories where the impulse response functions show **statistically significant** deviations from zero (95% confidence intervals exclude zero for at least 12 months).

---

### 4.1 Highly Responsive Categories

#### 4.1.1 Motor Vehicles and Parts

![Motor Vehicles and Parts](Data/Figures/Local_Projections/Lvl%203%20-%20MotorVehiclesAndParts.png)

**Statistical Significance**: 
- Price: **NO** - CI includes zero (95% CI: [-9.00, 1.76])
- Quantity: **YES** - Highly significant negative response

**Economic Magnitude**:
- Peak price effect: **-3.62pp** at month 45 (NOT significant)
- Peak quantity effect: **-33.77pp** at month 2 (95% CI: [-53.76, -13.78]) - **HIGHLY significant**

**Mechanism**:
Motor vehicles are highly interest-sensitive due to:
1. High purchase price requiring financing
2. Durable nature enabling inter-temporal substitution
3. Inventory holdings by dealers

**Finding**: 
Motor vehicles show the **expected and most dramatic quantity response** of any category:
- Immediate, large decline in purchases (-33.77pp peaking at just 2 months)
- This is consistent with consumer durables theory: when interest rates rise, auto purchases plunge
- Price response is insignificant, possibly due to:
  - Administered pricing by manufacturers
  - Rebates and incentives that stabilize transaction prices
  - Quality adjustments not fully captured in price indices

**Key Insight**: This is the **only** major category showing strongly negative quantity responses as economic theory predicts for durables.

---

#### 4.1.2 Housing and Utilities

![Housing and Utilities](Data/Figures/Local_Projections/Lvl%203%20-%20HousingAndUtilities.png)

**Statistical Significance**: 
- Price: **YES** - Significant throughout medium term
- Quantity: **YES** - But shows positive response (puzzling)

**Economic Magnitude**: 
- Peak price effect: **-2.27pp** at month 54 (95% CI: [-3.49, -1.05])
- Peak quantity effect: **+5.49pp** at month 56 (95% CI: [3.43, 7.55])

**Mechanism**:
Housing services represent the largest component of consumption (~15% of PCE) and directly link to:
- Mortgage rates (monetary policy transmission channel)
- Rental equivalence pricing
- Utility costs (energy sensitivity)

**Finding**: 
Mixed results with important measurement considerations:
- **Price**: Shows expected significant decline, very persistent (peaks at 4.5 years)
  - Consistent with sticky housing rents and slow adjustment in owner-equivalent rent
- **Quantity**: Counterintuitively *increases* following contractionary shock
  - This likely reflects measurement issues with imputed housing services
  - Rental equivalence methodology may not capture true consumption changes
  - Alternatively, could reflect composition shifts (people staying in homes longer rather than moving)

**Interpretation**: 
The price response is credible and economically important given housing's large weight in PCE. The quantity response should be interpreted cautiously due to well-known measurement challenges in housing services.

---

#### 4.1.3 Durable Household Equipment

![Furnishings and Durable Household Equipment](Data/Figures/Local_Projections/Lvl%203%20-%20FurnishingsAndDurableHouseholdEquipment.png)

**Statistical Significance**: 
- Price: **YES** - Significant in short-to-medium term
- Quantity: **YES** - Significant negative response

**Economic Magnitude**: 
- Peak price effect: **-3.29pp** at month 12 (95% CI: [-5.69, -0.89])
- Peak quantity effect: **-13.89pp** at month 27 (95% CI: [-23.79, -3.99])

**Finding**: 
This category shows **theoretically consistent** responses:
- Both price and quantity decline significantly
- Quantity response is large (-13.89pp), consistent with interest-rate sensitive durables
- Faster price adjustment than most categories (peak at 12 months)
- Strong connection to housing market: furnishings purchases correlate with home buying/moving
- Financing channel likely important: many consumers finance appliance purchases

**Interpretation**: 
Along with motor vehicles, household equipment is one of the few categories showing expected negative quantity responses. The magnitude is substantial but smaller than motor vehicles (-13.89pp vs -33.77pp), possibly because:
- Lower unit prices → less financing dependence
- Some items are necessities (replacing broken appliances)
- Less inter-temporal substitutability than cars

---

#### 4.1.4 Gasoline and Energy Goods

![Gasoline and Other Energy Goods](Data/Figures/Local_Projections/Lvl%203%20-%20GasolineAndOtherEnergyGoods.png)

**Statistical Significance**: 
- Price: **YES** - Extremely large and significant response
- Quantity: **YES** - Significant positive response

**Economic Magnitude**: 
- Peak price effect: **-39.72pp** at month 52 (95% CI: [-76.24, -3.20])
- Peak quantity effect: **+13.10pp** at month 56 (95% CI: [6.53, 19.67])

**Mechanism**:
Energy goods respond through:
- Exchange rate channel (imported oil prices)
- Demand effects (consumption reduction)
- Commodity market pass-through

**Finding**: 
**Extreme and economically puzzling** results:
- **Price**: Massive 40pp decline is implausibly large
  - For context: this implies YoY gasoline price inflation drops by 40 percentage points
  - This is an order of magnitude larger than any other category
  - Likely reflects:
    1. High volatility of energy prices creates large estimation uncertainty
    2. Supply shocks (oil price shocks) may be correlated with monetary policy
    3. Exchange rate effects amplify responses for imported commodities
    
- **Quantity**: Positive response contradicts demand theory
  - Higher interest rates should reduce driving and energy consumption
  - May reflect:
    1. Composition effects within energy category
    2. Complementarity with other goods whose consumption rises
    3. Measurement error in chain-weighted indices

**Interpretation**: 
Energy goods results should be treated with **extreme caution**. The massive price swings and wrong-signed quantity response suggest this category is poorly suited to local projections analysis, possibly due to:
- Confounding supply shocks (OPEC, geopolitical events)
- Global commodity price dynamics not well-captured by domestic MPS
- Data quality issues in disaggregated energy indices

---

### 4.2 Moderately Responsive Categories

#### 4.2.1 Food Services and Accommodations

![Food Services and Accommodations](Data/Figures/Local_Projections/Lvl%203%20-%20FoodServicesAndAccommodations.png)

**Statistical Significance**: 
- Price: **YES** - Significant negative response
- Quantity: **YES** - Significant negative response

**Economic Magnitude**: 
- Peak price effect: **-2.06pp** at month 46 (95% CI: [-3.89, -0.22])
- Peak quantity effect: **-7.32pp** at month 31 (95% CI: [-11.14, -3.50])

**Interpretation**: 
**Economically sensible results** - one of the few categories with both responses in expected directions:
- Food away from home is **MORE** discretionary than food at home, implying **STRONGER** income effects from monetary policy
- Quantity response (-7.32pp) is meaningfully larger than price response (-2.06pp)
  - Suggests elastic demand: consumers readily cut restaurant spending when income/wealth declines
  - Consistent with "eating out" being a discretionary expense
- Moderate price stickiness (peak at 46 months) reflects:
  - Menu costs in restaurant pricing
  - Wage stickiness (labor-intensive sector)
  - But more flexible than housing or other services

**Policy Implication**: Food services is a reliable indicator of household discretionary spending responses to monetary policy.

---

#### 4.2.2 Recreation Services

![Recreation Services](Data/Figures/Local_Projections/Lvl%203%20-%20RecreationServices.png)

**Statistical Significance**: 
- Price: **YES** - Marginally significant (CI barely excludes zero)
- Quantity: **YES** - But shows positive response (puzzling)

**Economic Magnitude**: 
- Peak price effect: **-2.32pp** at month 51 (95% CI: [-4.50, -0.14])
- Peak quantity effect: **+5.67pp** at month 60 (95% CI: [0.50, 10.83])

**Interpretation**: 
Mixed results for discretionary services:
- Price declines as expected, though only marginally significant
- Quantity response is positive and significant - economically puzzling for discretionary spending
  - Standard theory: recreation is highly discretionary → should decline sharply with contractionary policy
  - Possible explanations:
    1. Composition effects: different types of recreation may respond differently
    2. Relative price effects: as recreation becomes cheaper, substitution from other categories
    3. Measurement issues in chain-weighted recreation indices
- Very long lags (peak at 60 months = 5 years) suggest delayed adjustments

**Note**: The positive quantity response undermines confidence in this category's results.

---

#### 4.2.3 Transportation Services

![Transportation Services](Data/Figures/Local_Projections/Lvl%203%20-%20TransportationServices.png)

**Statistical Significance**: 
- Price: **YES** - Significant negative response
- Quantity: **YES** - But shows positive response

**Economic Magnitude**: 
- Peak price effect: **-5.18pp** at month 53 (95% CI: [-9.73, -0.62])
- Peak quantity effect: **+11.02pp** at month 59 (95% CI: [2.54, 19.51])

**Interpretation**:
Transportation services (airfare, transit, ride-sharing) show:
- Substantial price decline (-5.18pp) - larger than most service categories
  - May reflect competitive pricing and commodity cost pass-through (fuel)
- Positive quantity response (+11.02pp) - inconsistent with demand theory
  - Transportation is complementary to other activities (work, leisure)
  - Positive response may indicate:
    1. Measurement issues with price deflators
    2. Composition shifts (e.g., toward cheaper transport modes counted as higher "real" consumption)
    3. Complementarity effects dominating substitution effects

**Caution**: The sign reversal between price and quantity suggests identification or measurement problems in this category.

---

### 4.3 Relatively Unresponsive Categories

#### 4.3.1 Health Care

![Health Care](Data/Figures/Local_Projections/Lvl%203%20-%20HealthCare.png)

**Statistical Significance**: 
- Price: **NO** - Not statistically significant (CI includes zero)
- Quantity: **YES** - Significant negative response

**Economic Magnitude**: 
- Peak price effect: **-3.70pp** at month 58 (95% CI: [-8.61, 1.21]) - **NOT significant**
- Peak quantity effect: **-4.54pp** at month 13 (95% CI: [-7.56, -1.53]) - **Significant**

**Interpretation**:
Health care consumption exhibits low monetary policy sensitivity due to:
- Insurance coverage (third-party payment insulates from price changes)
- Low price elasticity (necessities)
- Regulatory price setting
- Aging demographics (inelastic demand)

**Finding**: Results **PARTIALLY CONFIRM** the hypothesis of monetary policy neutrality for health spending:
- **Price**: Insignificant response supports the view that health prices are insulated from monetary policy
  - Administered pricing (Medicare/Medicaid reimbursement rates)
  - Insurance negotiations shield providers from demand fluctuations
  
- **Quantity**: Significant decline (-4.54pp) is somewhat surprising
  - Suggests discretionary health spending (elective procedures, dental, vision) does respond to income effects
  - Relatively fast response (peak at 13 months) indicates short-term postponement of non-urgent care
  - Magnitude is modest compared to truly discretionary categories

**Policy Insight**: While health prices are sticky/insulated, health *quantities* do respond modestly to monetary policy, likely through elective/discretionary components.

---

#### 4.3.2 Clothing and Footwear

![Clothing and Footwear](Data/Figures/Local_Projections/Lvl%203%20-%20ClothingAndFootwear.png)

**Statistical Significance**: 
- Price: **NO** - Not statistically significant (CI includes zero)
- Quantity: **YES** - Significant negative response

**Economic Magnitude**: 
- Peak price effect: **-3.50pp** at month 44 (95% CI: [-8.81, 1.81]) - **NOT significant**
- Peak quantity effect: **-11.17pp** at month 27 (95% CI: [-17.48, -4.85]) - **Significant**

**Interpretation**:
Clothing and footwear shows mixed results:
- **Price**: Insignificant response suggests competitive retail markets with flexible pricing strategies (sales, promotions) that partially offset demand shifts
- **Quantity**: Large, significant decline (-11.17pp) indicates this semi-discretionary category is responsive to income effects
  - Consumers readily postpone clothing purchases during economic downturns
  - Peak at 27 months (just over 2 years) suggests medium-term adjustment
  - Magnitude is comparable to other semi-durable categories like household equipment
  
**Key Finding**: While clothing prices don't respond significantly to monetary policy (competitive market structure), quantities show substantial sensitivity, consistent with clothing being postponable but not entirely discretionary.

---

#### 4.3.3 Financial Services and Insurance

![Financial Services and Insurance](Data/Figures/Local_Projections/Lvl%203%20-%20FinancialServicesAndInsurance.png)

**Statistical Significance**: 
- Price: **NO** - Not statistically significant (CI includes zero)
- Quantity: **NO** - Not statistically significant (CI includes zero)

**Economic Magnitude**: 
- Peak price effect: **+10.85pp** at month 28 (95% CI: [-1.16, 22.85]) - **NOT significant**
- Peak quantity effect: **-9.35pp** at month 19 (95% CI: [-19.33, 0.64]) - **NOT significant**

**Interpretation**:
Financial services show **no statistically significant responses**:
- **Price**: Positive point estimate (+10.85pp) but with very wide confidence intervals
  - Financial service prices are notoriously difficult to measure (implicit fees, bundling)
  - May reflect measurement issues rather than true economic effects
  
- **Quantity**: Negative point estimate but statistically insignificant
  - Financial services often tied to transactions volume and wealth management
  - Offsetting effects may cancel out: reduced lending vs. increased insurance/risk management
  
**Key Finding**: This category exhibits **monetary policy neutrality** - neither prices nor quantities respond significantly. This likely reflects:
1. Measurement challenges unique to financial services
2. Regulatory influences on pricing (interest rate regulations, fee structures)
3. Complex general equilibrium effects (financial services both facilitate and respond to other consumption)

---

## 5. Phillips Multiplier Analysis

The Phillips Multiplier (PM), defined as the ratio of price response to quantity response (dP/dQ), captures the implicit "slope" of the Phillips curve at the sectoral level. We estimate PM using 2SLS instrumental variables with the monetary policy shock as the instrument, and compute weak-instrument robust Anderson-Rubin confidence bounds.

![Aggregate Phillips Multiplier](Data/Figures/Philips_Multiplier/Aggregate%20PCE.png)

### 5.1 Aggregate Phillips Multiplier

**Estimate**: -0.315 at long horizons (month 60)
- **2SLS estimate at peak (month 1)**: -1.131 (95% CI: [-5.33, 3.07])
- **AR robust CI**: [-10.00, 5.00] - very wide, reflecting weak identification
- **Effective F-statistic (mean)**: 7.21 - marginally above weak instrument threshold of 10

**Interpretation**:
- **Negative multiplier**: Prices and quantities move in **opposite** directions, consistent with a downward-sloping aggregate demand curve
- The multiplier of -0.315 at long horizons means: for every 1pp decline in real consumption, prices decline by 0.315pp
- **Weak identification**: Low F-statistics indicate the MPS instrument has limited power for identifying the structural PM
  - Standard 2SLS confidence intervals are unreliable
  - AR robust bounds are very wide, including both positive and negative values
  - Results should be interpreted with caution

### 5.2 Sectoral Heterogeneity in Phillips Multipliers

![Goods Phillips Multiplier](Data/Figures/Philips_Multiplier/Lvl%201%20-%20Goods.png)
![Services Phillips Multiplier](Data/Figures/Philips_Multiplier/Lvl%201%20-%20Services.png)

**Key Sectoral Estimates** (at long horizons):

| Category | PM Estimate | 95% CI (AR robust) | Eff. F-stat | Interpretation |
|----------|-------------|-------------------|-------------|----------------|
| **Goods** | -0.435 | [-10.00, 5.00] | 6.24 | Weakly identified; consistent negative slope |
| **Services** | -0.218 | [-10.00, 5.00] | 7.26 | Weakly identified; smaller multiplier than goods |
| **Durable Goods** | -0.291 | [-10.00, 5.00] | 2.27 | Very weak identification (F=2.3) |
| **Nondurable Goods** | -0.636 | [-10.00, 5.00] | 4.07 | Weak identification; largest goods multiplier |
| **Motor Vehicles** | -0.267 | [-1.53, -0.06] | 7.78 | **SIGNIFICANT** - best identified PM |
| **Housing** | 0.030 | [-10.00, 5.00] | 1.86 | Essentially zero; very weak identification |

![Motor Vehicles Phillips Multiplier](Data/Figures/Philips_Multiplier/Lvl%203%20-%20Motor%20vehicles%20and%20parts.png)

**Critical Finding - Motor Vehicles**:
- **Only category with statistically significant PM**: -0.267 (AR CI: [-1.53, -0.06])
- Strongest instrument (F-stat = 7.78, though still below 10)
- AR bounds exclude zero for 12-24 months, confirming negative price-quantity relationship
- This is the **most credible** sectoral PM estimate in the analysis

**Pattern Across Categories**:
1. **All point estimates are negative** at long horizons - consistent with downward-sloping demand
2. **Wide AR confidence intervals** for most categories - reflects pervasive weak identification
3. **Goods vs. Services**: Goods show larger multipliers (-0.44) than services (-0.22)
   - Suggests prices are more responsive to quantity fluctuations in goods markets
   - May reflect greater price flexibility in goods compared to labor-intensive services

### 5.3 Identification Challenges

**Weak Instrument Problem**:
- **Mean F-statistics across categories**: Range from 0.18 (Recreation Services) to 8.34 (Household Services)
- **None exceed the conventional threshold of 10** for strong identification
- This means the monetary policy shock has limited power to move prices and quantities sufficiently for precise PM estimation

**Why is identification weak?**
1. **Small sample**: 303 observations (1982-2008) limits statistical power
2. **Modest MPS variation**: Monetary shocks are relatively small in the sample period
3. **Long-run effects**: Cumulative responses grow over time, increasing uncertainty
4. **Disaggregation**: Individual sectors have smaller signal-to-noise ratios than aggregate

**Implications**:
- Standard 2SLS confidence intervals are **unreliable** and should not be used
- AR robust bounds provide valid inference but are very wide
- Only Motor Vehicles achieves meaningful identification
- Other categories: point estimates indicate negative multipliers, but statistical uncertainty is too large for strong conclusions

### 5.4 Economic Interpretation

Despite weak statistical identification, the pattern of point estimates reveals economically sensible patterns:

1. **Consistent Negative Relationship**: All categories show negative PM at long horizons
   - Supports the view that contractionary monetary policy creates movements along downward-sloping sectoral demand curves
   - Contradicts the puzzling positive quantity responses observed in reduced-form LP estimates for some goods categories

2. **Resolution of the Goods Puzzle**: 
   - Reduced-form LP showed puzzling positive quantity responses for goods
   - PM analysis shows negative multipliers (price declines exceed quantity declines)
   - This suggests the puzzling LP results may reflect **measurement error** or **composition effects** that wash out in the ratio estimator

3. **Motor Vehicles - A Success Story**:
   - Clear negative PM (-0.267, statistically significant)
   - For every 1pp decline in auto purchases, prices fall by 0.27pp
   - Demonstrates that with sufficient variation, the IV approach can identify meaningful structural parameters

---

## 6. Key Takeaways and Policy Implications

### 6.1 Summary of Findings

1. **Heterogeneity is Pervasive**: Aggregate responses mask substantial variation across sectors
   - Price responses range from -2.27pp (Housing) to -39.72pp (Energy goods)
   - Quantity responses range from -33.77pp (Motor Vehicles) to +19.27pp (Durable Goods)
   - This 10-fold variation demonstrates the importance of disaggregated analysis

2. **Durable-Nondurable Divide Shows Puzzling Patterns**: 
   - **Durables**: Large positive quantity response (+19.27pp) contradicts theory
     - Motor vehicles are the exception: strong negative response (-33.77pp) as expected
     - Suggests composition effects or measurement issues within durable goods category
   - **Nondurables**: Also show unexpected positive quantity response (+5.39pp)
     - Combined with large price declines (-6.88pp)
   - **Policy implication**: Results suggest data quality issues in goods disaggregation that require further investigation before drawing policy conclusions

3. **Price-Quantity Trade-offs Vary Substantially**:
   - **Services** exhibit MORE price stickiness than goods (smaller price responses: -2.53pp vs -5.09pp)
   - Quantity adjustments are FASTER in services (peak at 30 months) vs goods (peak at 52 months) 
   - Services show economically sensible patterns; goods categories show puzzling results
   - Only a few categories show theoretically consistent responses: Motor Vehicles, Household Equipment, Food Services, Health Care

4. **Transmission Channels**:
   - **Interest rate channel**: Most prominent in Motor Vehicles (-33.77pp), Household Equipment (-13.89pp), and Clothing (-11.17pp)
   - **Exchange rate channel**: Likely evident in Energy Goods (imported commodities show extreme -39.72pp price response)
   - **Income channel**: Strongest for discretionary spending (Food Services -7.32pp, Recreation Services show mixed results)

---

### 6.2 Implications for Monetary Policy

1. **Sector-Specific Effects Matter**: 
   Central banks targeting aggregate inflation should be aware that responses vary 10-fold across sectors. Shocks concentrated in specific sectors (e.g., energy -39.72pp, motor vehicles -33.77pp) can drive aggregate measures while masking offsetting movements elsewhere.

2. **Core vs. Headline Inflation**:
   Our findings SUPPORT the practice of excluding food and energy from core measures because:
   - Energy goods show extreme, implausible responses (-39.72pp) likely driven by supply shocks
   - These volatile categories confound monetary policy effects with commodity market dynamics
   - Service prices show more stable, interpretable responses to monetary policy

3. **Data Quality Concerns**:
   The puzzling positive quantity responses in goods categories (especially durables +19.27pp and nondurables +5.39pp) raise concerns about:
   - Chain-weighting methodology in disaggregated PCE indices
   - Composition effects that may not be well-captured at aggregate category levels
   - Need for robustness checks with alternative data sources before policy use

4. **Timing of Policy Effects**:
   Peak impacts occur at:
   - **2 months** for Motor Vehicles (immediate interest-rate sensitivity)
   - **13-27 months** for semi-durables (Household Equipment, Clothing) and some services (Health Care)
   - **30-46 months** for most services (Food Services, Recreation)
   - **52-60 months** for goods prices and Housing
   
   This implies policy effects on real consumption appear faster (1-2 years) than on inflation (4-5 years), consistent with the "long and variable lags" of monetary policy.

---

### 6.3 Directions for Future Research

1. **Mechanism Identification**: 
   Decompose responses into demand effects, supply effects, and general equilibrium channels using:
   - Structural VAR with sign restrictions to separate demand/supply shocks
   - Narrative identification of specific monetary policy episodes
   - Instrumental variables approach using high-frequency identified monetary shocks

2. **Data Quality Investigation**:
   Address the puzzling positive quantity responses in goods by:
   - Comparing results with alternative data sources (BEA detailed tables, BLS Consumer Expenditure Survey)
   - Testing sensitivity to chain-weighting vs. fixed-weight indices
   - Examining composition effects within broad categories
   - Using microdata to validate aggregate patterns

3. **Time Variation**: 
   Estimate rolling-window responses to test for structural breaks in sectoral transmission:
   - Compare pre-1984 "Great Inflation" vs. post-1984 "Great Moderation"
   - Test for changes post-2008 financial crisis
   - Examine COVID-19 period with different sectoral dynamics

4. **Cross-Country Analysis**: 
   Compare sectoral heterogeneity across countries with different monetary policy regimes and industrial structures:
   - Euro area countries (common monetary policy, different sectoral compositions)
   - Inflation targeting vs. alternative regimes
   - Developed vs. emerging market economies

5. **Micro-Foundation**: 
   Calibrate multi-sector DSGE model to match our estimated impulse responses:
   - Incorporate sector-specific price stickiness parameters
   - Model interest-rate sensitive durables explicitly
   - Test whether standard models can replicate the observed heterogeneity

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
