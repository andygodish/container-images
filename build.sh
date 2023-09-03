#!/bin/bash

# root directory of the repository
root_dir=$PWD

# These are base images built from the same public base image
base_dir=$1

# Private registry hosts
dockerhub="docker.io/andygodish/"

function build_and_push_docker_image() {
    dockerfile_path=$1
    dockerfile_dir=$(dirname "$dockerfile_path")
    dockerfile_base=$(basename "$dockerfile_path")

    echo "Building docker image from $dockerfile_path"

    # Default tag
    image_tag="latest"

    # Check if it's a *.dockerfile - if so, use the filename prefix as the tag
    if [[ $dockerfile_path == *".dockerfile" ]]; then
        image_tag="${dockerfile_base%.dockerfile}"
        image_name=${dockerfile_dir//$root_dir/base}

        # for pushing to dockerhub, can't have a nested directory structure
        image_name=$(echo "$image_name" | sed 's/\//-/g')
    fi

    # Check if dockerfile is named 'dockerfile', if so, add the tag in the FROM statement to the image name
    if [[ $dockerfile_base == "dockerfile" ]]; then
        from=$(awk '/FROM/{print $2}' "$dockerfile_path")
        first_line=$(echo "$from" | head -n 1)
        from_tag=${first_line#*:}

        # Split images_name into array using / as a delimiter
        IFS='/' read -ra path_parts <<< "$dockerfile_dir"

        # Insert from_tag at second-to-last position
        length=${#path_parts[@]}
        path_parts[length-1]="$from_tag/${path_parts[length-1]}"

        # Join path_parts back into a string
        IFS='/'
        rejoined="${path_parts[*]}"
        unset IFS
        image_name=${rejoined//$root_dir/base}

        # for pushing to dockerhub, can't have a nested directory structure
        image_name=$(echo "$image_name" | sed 's/\//-/g')

        year_date_tag=$(date +%Y-%m)
    fi

    docker build -f $dockerfile_path -t $image_name:$image_tag .
    
    # Tag the image for each registry
    docker tag $image_name:$image_tag $dockerhub$image_name:$image_tag 
    if [[ $dockerfile_base == "dockerfile" ]]; then
        docker tag $image_name:$image_tag $dockerhub$image_name:$year_date_tag
    fi

    # Push the image to each registry
    docker push $dockerhub$image_name:$image_tag
    if [[ $dockerfile_base == "dockerfile" ]]; then
        docker push $dockerhub$image_name:$year_date_tag
    fi
}

for dockerfile in $(find $root_dir/$base_dir \( -name dockerfile -o -name "*\.dockerfile" \)); do
    build_and_push_docker_image $dockerfile
done

