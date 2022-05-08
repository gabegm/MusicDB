# Music

## Installation

```
$ python -m venv ~/envs/music
$ source ~/envs/music/bin/activate
$ pip install -r requirements.txt
$ python -m ipykernel install --user --name=music
$ chmod +x init.sh
```

## Getting Started

```
$ ./init.sh
```

# Core data

* Artists
  * Name
  * sort name
  * IPI
  * aliases
  * type
  * begin date
  * end date
  * disambiguation comment
  * MBID

* Release Groups
  * Title
  * artist credit
  * type
  * disambiguation comment
  * MBID

* Releases
  * Title
  * artist credit
  * type
  * status
  * language
  * date
  * country
  * label
  * catalog number
  * barcode
  * medium(s)
  * disc ID(s)
  * ASIN
  * disambiguation comment
  * MBID

* Mediums
  * Format
  * list of tracks (title, artist credit, duration)

* Recordings
  * Title
  * artist credit
  * duration
  * ISRC
  * PUIDs
  * relationships
  * disambiguation comment
  * MBID

* Works
  * Title
  * ISWC
  * relationships
  * disambiguation comment
  * MBID

* Labels
  * Name
  * sort name
  * aliases
  * country
  * type
  * code
  * begin date
  * end date
  * disambiguation comment
  * MBID

* Relationships & URLs
    Relationships are a way to link the above entities together and allow MusicBrainz to capture most of the data contained in the liner notes of a CD.

* CD Stubs
  * Title
  * artist
  * barcode
  * disc ID
  * disambiguation comment

# Supplementary data

* user submitted annotations, tags and ratings
* derived statistics
* search indexes
* edit history