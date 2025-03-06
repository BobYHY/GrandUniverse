# The Grand Biological Universe: A Comprehensive Geometric Construction of Genome Space

## Abstract
Analyzing the geometric relationships among genomic sequences from a mathematical perspective and revealing the laws hidden within these relationships is a crucial challenge in bioinformatics. The natural vector method constructs a genome space by extracting statistical moments of k-mers to illuminate the relationships among genomes. This approach highlights a fundamental law in biology known as the convex hull principle, which states that natural vectors corresponding to different types of biological sequences form distinct, non-overlapping convex hulls. Previous studies have validated this important principle across various datasets. However, they often focused on specific kingdoms and did not thoroughly analyze the significance of the dimensions required for the convex hull separation. In this study, we integrate all reliable sequences from different kingdoms to construct the Grand Biological Universe, within which we comprehensively validate the convex hull principle. We demonstrate that the separation of convex hulls arises from biological properties rather than mathematical characteristics of high-dimensional spaces. Furthermore, we develop suitable metrics within the Grand Biological Universe to facilitate efficient sequence classification. This research advances the convex hull principle through both theoretical development and experimental validation, making significant contributions to the understanding of the geometric structure of genome space.

## File Structure Overview

### **Sequence Information (`S1_to_S12.xlsx`)**  
  Information for all sequences containing: Sequence Accession Number, Sequence Length, Sequence Family, Sequence Name

### Code Directory (`code/`)
- **Natural Vector Generation(`nv.m, kmernv.m`)** - Converts biological sequences to natural vectors.
- **Convex Hull Intersection Analysis(`intersection.m, ConvexHullDimensionAnalysis.m`)** - Analyzes intersection between convex hulls.
- **Integrated Analysis Pipeline(`run.m`)** - One-click script for rapid convex hull analysis.
- **Test Dataset(`fasta_files/, Accession.xlsx`)** - Sample data for `run.m`.

### Phylogenetic Trees Directory (`Phylogenetic_Trees/`)
Contains phylogenetic tree files for biological galaxies.

---

## Code Reproduction Guide

### Execution Requirements
**Environment:** MATLAB

**Input Data Structure:**
1. **Metadata File**  
   - Create an Excel file (e.g., `Accession.xlsx`) following this format:
     ```excel
     | Accession  | Family     |
     |------------|------------|
     | S001       | Family1    |
     | S002       | Family2    |
     ```

2. **Sequence Storage**  
   - Create a directory named `fastafiles/` in your project root
   - Store each sequence as an individual FASTA file with:
     - **Filename:** `<SequenceID>.fasta` (e.g., `S001.fasta`) (`S001.1.fasta` is not allowed.)
     - **Format:**  
       ```fasta
       >[Optional header]
       ATGCTAGCTAGCTAGCTAGC...  # Raw nucleotide sequence
       ```

