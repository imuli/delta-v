
## House System

### Needs

#### Space Heat

It's cold in the winter!
The space is insulated but, especially with all those windows, we'll want heat.
Low grade is perfectly fine, but lots of quantity.

#### Cooking Heat

Nice flexible heat sources that can be turned on and off quickly and are clean to interact with.
Low grade and low quantity.

Also one of the six systems to be considered a [motor home](../legal/title10ch214-A.pdf) is "A cooking facility with an on-board fuel-source."

#### Low Voltage DC

Most needs are <16volt, a couple in the 20-24v, possibly some 48-60v loads.
Fairly low power all in all, maybe 1kW max.

#### AC

Depends on stuff, probably mostly guest use?

#### High Voltage DC / 3-phase Square Wave

For driving the bus if eventually converted to electric.
Large intermitant loads >100kW.

### Heat Sources

In the not-summer it'll be cold outside!

Also one of the six systems to be considered a [motor home](../legal/title10ch214-A.pdf) is "A heating or air-conditioning system with an on-board power or fuel source separate from the vehicle engine"

#### Wood, Charcoal, and other solid fuels

A well-insulated firebox with an extra-insulated chimney (aka rocket stove) will burn quite hot and efficiently.
Capturing and storing that energy in a bus is a little trickier, but definitely doable.

#### Waste Vegitible Oil and other liquid fuels

Very similar setup to the rocket stove, but doesn't need the firebox.
Produces higher grade heat than wood or charcoal.
Requires a blower for high efficiency burning.

The liquid and solid furnaces could be combined with a sliding floor at the top of the firebox...

#### Propane, Hydrogen, and other gaseous fuels

For cooking? For refrigeration? For heating?

Combined propane / waste oil furances are a thing.

During times that we have excess energy hydrogen is relatively easily made,
just hard to store compactly.

### Electricity Generation

#### Solar Panels

On the roof, on the designated south side of the bus. Obviously.

Panels often put out 18V and aren't great in series with partial shading.
Integrating individual buck/boost converters maybe makes sense even for parallel.

#### From Heat Sources

The general goal is to be able to generate power as an byproduct of heating the bus.
General methods are:

* Steam turbine
* Thermal decomposition cycles (boron?)
* Solid state thermoelectric generators (expensive)

#### Fuel Cells

{insert research on waste oil fuel cells here}

#### Engine/Transmission

(Potential for regenerative breaking instead of engine breaking?)

### Electricity Storage and Conversion

|  Consideration   |   Li-Ion   | Lead-Acid | Notes
| ---------------  | ---------- | --------- | -----
| Specific Energy  | 175 Wh/kg  | 35 Wh/kg  |
| Specific Power   | 300 W/kg   | 180 W/kg  | Especially important for intermitant loads.
| Cycle Efficiency | >95%       | 75%       |
| Cycle Durability | ~1000	| <350      |
| Charging Circuit | Simple     | Complex   |
| Upfront Cost     | 40 ¢/Wh    | 12 ¢/Wh   | Can acquire Li-Ion for much cheaper now.
| Levelized Cost   | 12 ¢/kWh   | 18 ¢/kWh  | [Cents per kWh stored over lifetime of battery.](https://saurorja.org/2011/08/30/lead-acid-is-the-cheapest-battery-conditions-apply/)

Lithium Ion is the clear winner here.
NaS (Sodium-Sulphur) probably would win out in a stationary large scale application though.

#### Low Voltage DC

Pretty much two options that make sense:

* 4 groups of Li-Ion cells in series. 12-16V.
  * Can directly power a lot of loads:
    * our laptops
    * most mobile radios
    * battery charger
    * speakers
    * the bus power system
  * easy to charge from "12V" solar panels
  * conversion to 24-48V is common
  * bidirectional to 390V is rare
  * can probably use to start the bus
* 15 groups of Li-Ion cells in series. 45-60V.
  * Can power PoE and telecom-style equipment directly (unlikely to have much of that).
  * easy bidirectional conversion to 390 or 12V
  * more efficient inverters to 120/240VAC

Given that almost all our loads are 12-16V or under, 4 cells probably makes sense.

Limiting charge range on Li-Ions to 3.1-3.9 V/cell is probably desirable.
* dead simple charge-discharge cycle (max current / max voltage)
* extended battery life (more total Wh in and out)
* 15.6V is quite safe for 16V capacators that most 12V loads use.

#### 120~240 VAC

* Guests will probably not have their lives wired for 12V,
  so having 120VAC available for them would be handy.
* Inverters are available for all battery setups.
  * A simple (silenced) UPS might do fine for 120.
* One of the qualifications to be considered a [motor home](../legal/title10ch214-A.pdf)
  is "A 110-volt to 125volt electric power supply."
  So even if we don't use it very much, it's an easy way to get one of the four of the six we need.

##### Flywheel storage

High speed lightweight flywheel storage is a thing.
* Naturally produces 3-phase perfect sine wave AC.
* You'd need two spinning in opposite directions to keep the bus balanced.
* Very high specific energy and extremely high specific power.
* Not available as an commercial off the shelf product AFAIK.

#### High Voltage DC

* 100 groups of Li-Ion cells in series. 300-400V.
  * Easy enough to downconvert to 12 or 48V if needed.
  * Very efficient inverters (expensive?) to 120/240VAC

## Locomotion System

Initially we're looking at straight diesel fuel.
At some point, order of a year or so,
I want to augment that to use waste vegitible oil once the engine is hot.
The process seems fairly straightforward, but needs more research.

Long term, on the order of many years,
I want to convert to electric and integrate locomotion energy with the rest of the system.

