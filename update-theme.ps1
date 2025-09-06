$files = @(
    "catalogue.index.html",
    "Celebrations.index.html", 
    "Conversation.index.html",
    "Creators.index.html",
    "culture.creators.index.html",
    "history.html",
    "history2.html", 
    "history3.html",
    "history4.html",
    "history5.html",
    "Playlist.index.html",
    "ShopClothing.index.html",
    "Us.index.html"
)

$newStyles = @"
   <style>
        /* Updated energetic color scheme */
        .black {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
            border-radius: 15px;
        }
        .orange{
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            border-radius: 10px;
        }
        .border-orange{
            border: 3px solid #667eea;
            box-shadow: 0 0 20px rgba(102, 126, 234, 0.4);
        }
        .text-orange{
            color: #f5576c;
            text-shadow: 0 2px 4px rgba(245, 87, 108, 0.3);
        }
        
        /* Cool effects */
        .energetic-glow {
            animation: glow 2s ease-in-out infinite alternate;
        }
        
        @keyframes glow {
            from { box-shadow: 0 0 10px #667eea, 0 0 20px #667eea, 0 0 30px #667eea; }
            to { box-shadow: 0 0 20px #f5576c, 0 0 30px #f5576c, 0 0 40px #f5576c; }
        }
    </style>
"@

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw
        
        # Update favicon
        $content = $content -replace 'Images/idh kamono/Inside Deep House logo 1small\.png', 'Images/logo/Energetic Deep House Magazine Logo Design_20250630_152517_0000.png'
        
        # Update old style block
        $oldStyle = @"
   <style>
        \.black \{background-color: rgb\(255, 167, 59\);\}
        \.orange\{background-color: rgb\(245, 185, 112\);\}
        \.border-orange\{border: 7px solid rgb\(255, 167, 59\);\}
        \.text-orange\{color: orange;\}
    </style>
"@
        
        $content = $content -replace $oldStyle, $newStyles
        
        # Remove bg-orange class from body
        $content = $content -replace 'class="bg-orange"', ''
        
        Set-Content $file -Value $content
        Write-Host "Updated: $file"
    }
}

Write-Host "All files updated with new energetic theme!"
