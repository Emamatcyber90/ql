# Improvements to C/C++ analysis

## General improvements

## New queries

| **Query**                   | **Tags**  | **Purpose**                                                        |
|-----------------------------|-----------|--------------------------------------------------------------------|
| *@name of query (Query ID)* | *Tags*    |*Aim of the new query and whether it is enabled by default or not*  |

## Changes to existing queries

| **Query**                  | **Expected impact**    | **Change**                                                       |
|----------------------------|------------------------|------------------------------------------------------------------|
| Resource not released in destructor | Fewer false positive results | Placement new is now excluded from the query. |
| Wrong type of arguments to formatting function | Fewer false positive results | False positive results involving typedefs have been removed. |
| Missing return statement (`cpp/missing-return`) | Visible by default | The precision of this query has been increased from 'medium' to 'high', which makes it visible by default in LGTM. It was 'medium' in release 1.17 and 1.18 because it had false positives due to an extractor bug that was fixed in 1.18. |

## Changes to QL libraries

* Added a hash consing library for structural comparison of expressions.