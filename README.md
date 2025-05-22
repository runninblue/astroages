# Historical Context
## Precession of the Equinoxes
In the 2nd century BCE, Hipparchus of Nicaea discovered the precession of the equinoxes, a fundamental astronomical phenomenon.\
Precession refers to the gradual shift in the orientation of Earth's axis of rotation, which causes the positions of the equinoxes to move slowly westward along the ecliptic, completing a full cycle approximately every 26,000 years (Platonic Year).\
Hipparchus' calculation of the precession rate was remarkably close to the modern value, estimating it at roughly 1° per century, which is only slightly different from the current measurement of approximately 1° every 72 years.\
The recognition of precession had profound implications for astrology, particularly in the development of the concept of astrological ages.\
As the equinoxes precess through the zodiac, they mark the beginning and end of these ages, each lasting roughly 2,160 years, based on the 12 zodiacal constellations.

<p align="center">
  <img src="https://people.highline.edu/iglozman/classes/astronotes/media/zodiacage.gif">
</p>

## Astrological ages
The shift from one age to another astrological age is thought to bring about significant cultural and spiritual changes, a belief that has influenced astrological thought since antiquity.\
Astrologers tend to view different historical periods as being dominated by the influence of particular signs.\
Presently, the vernal equinox is in the constellation Pisces. This age is commonly described as the age of faith and religion. It began roughly with the birth of Christ, about 2000 years ago. The New Testament is replete with fish symbolism. It should not be too surprising, therefore, that the symbol of Christianity has been fish.\
The preceding age was the Age of Aries, often described by astrologers as an age of aggression and enterprise. The Arian Age ushered in efforts to replace polytheism with monotheism. This is the age of Moses and the Old Testament. The symbol of Aries can be seen as representing the power of multiple gods streaming down into a single god-head. The Jews still blow the shofar (ram’s horn) in commemoration.\
The age of Taurus (the bull) preceded the Age of Aries. The 'golden calf' represents represents idol worshiping in general and a bull deity in particular, prominent in this age. Moses condemning his own people upon finding them worshiping a 'golden calf' after coming down from Mount Sinai. This condemnation ushers in the next age, the age of the Old Testament, the Age of Aries.\
The vernal equinox is approaching Aquarius. According to astrological mysticism, the age of Aquarius is characterized by spiritual enlightenment and unusual harmony and understanding in the world. Unfortunately, there is no evidence that the position of the vernal equinox with respect to the constellations of the Zodiac will bring such harmony.

### Sources
[Astrological age](https://en.wikipedia.org/wiki/Astrological_age)\
[Highline College - Cycles](https://people.highline.edu/iglozman/classes/astronotes/cycles.htm)

# Astroages
## Overview
Astroages is a simple utility written in Python and SQL that uses the CLI to build a table containing the astrological ages in which the provided year(s) belong to.

## Requirements
- Python 3
- PostgreSQL

## Installation
1. Create a database in PostgreSQL and run the scripts provided in db_scripts
2. Fill in the database details in db-template.ini and save it as db.ini
3. Run `pip install -r /path/to/requirements.txt` to install required libraries

## Usage
To run the program use:
`python astroages.py [start_year] [end_year]`
