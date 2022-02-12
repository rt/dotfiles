export const formatTime = (time) => {
    return time.toTimeString().replace(/.*(\d{2}:\d{2}:\d{2}).*/, '$1');
};

export default { formatTime };
