use ExtUtils::MakeMaker;

@scripts = grep {-f } glob("scripts/*.*");

WriteMakefile (
        NAME => "Font::Fret",
        VERSION_FROM => "lib/Font/Fret.pm",
        EXE_FILES => \@scripts,
        AUTHOR => "martin_hosken\@sil.org",
        ABSTRACT => "Font REporting Tool",
        PREREQ_PM => {
            'Font::TTF::Font' => 0.13,
            'Text::PDF::File' => 0.05
            }
    );
    
