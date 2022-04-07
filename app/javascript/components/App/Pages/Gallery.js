import React from 'react';
import GallerySideMenu from '../GallerySideMenu/GallerySideMenu';
import GalleryFilters from '../GalleryFilters/GalleryFilters';
import NftItem from '../NftItem/NftItem';

class Gallery extends React.Component {
  render () {
    const fakeNftList = [
      {
        title: "CAMAP: Artificial neural networks unveil the role of codon arrangement in modulating MHC-I peptides presentation",
        category: "biology",
        price: 13.36,
        author: 'John Doe'
      },
      {
        title: "Enhanced four-wave mixing from multi-resonant silicon dimer-hole membrane metasurfaces",
        category: "physics",
        price: 13.36,
        author: 'John Doe'
      },
      {
        title: "Supramolecular strategies in artificial photosynthesis",
        category: "chemistry",
        price: 13.36,
        author: 'John Doe'
      },
      {
        title: "Fermi surface transformation at the pseudogap critical point of a cuprate superconductor",
        category: "physics",
        price: 13.36,
        author: 'John Doe'
      },
      {
        title: "The Hitchhiker's guide to biocatalysis: recent advances in the use of enzymes in organic synthesis",
        category: "chemistry",
        price: 13.36,
        author: 'John Doe'
      },
      {
        title: "Effect of gut microbiota on depressive-like behaviors in mice is mediated by the endocannabinoid systems",
        category: "biology",
        price: 13.36,
        author: 'John Doe'
      },
      {
        title: "Effect of gut microbiota on depressive-like behaviors in mice is mediated by the endocannabinoid system",
        category: "physics",
        price: 13.36,
        author: 'John Doe'
      },
      {
        title: "Design of molecular water oxidation catalysts with earth-abundant metal ions",
        category: "chemistry",
        price: 13.36,
        author: 'John Doe'
      },
      {
        title: "CAMAP: Artificial neural networks unveil the role of codon arrangement in modulating MHC-I peptides presentation",
        category: "biology",
        price: 13.36,
        author: 'John Doe'
      },
      {
        title: "Enhanced four-wave mixing from multi-resonant silicon dimer-hole membrane metasurfaces",
        category: "physics",
        price: 13.36,
        author: 'John Doe'
      },
      {
        title: "Supramolecular strategies in artificial photosynthesis",
        category: "chemistry",
        price: 13.36,
        author: 'John Doe'
      },
      {
        title: "Fermi surface transformation at the pseudogap critical point of a cuprate superconductor",
        category: "physics",
        price: 13.36,
        author: 'John Doe'
      },
      {
        title: "The Hitchhiker's guide to biocatalysis: recent advances in the use of enzymes in organic synthesis",
        category: "chemistry",
        price: 13.36,
        author: 'John Doe'
      },
      {
        title: "Effect of gut microbiota on depressive-like behaviors in mice is mediated by the endocannabinoid systems",
        category: "biology",
        price: 13.36,
        author: 'John Doe'
      },
      {
        title: "Effect of gut microbiota on depressive-like behaviors in mice is mediated by the endocannabinoid system",
        category: "physics",
        price: 13.36,
        author: 'John Doe'
      },
      {
        title: "Design of molecular water oxidation catalysts with earth-abundant metal ions",
        category: "chemistry",
        price: 13.36,
        author: 'John Doe'
      },
    ];

    return (
      <>
        <GallerySideMenu />
        <div className="gallery-content-area">
          <GalleryFilters />
          <div className="nft-list">
            {fakeNftList.map(nft => (
              <NftItem
                title={nft.title}
                category={nft.category}
                price={nft.price}
                author={nft.author}
              />
            ))}
          </div>
        </div>
      </>
    );
  }
};

export default Gallery;